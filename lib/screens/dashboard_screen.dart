import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<FuelEntry>('fuel_entries').listenable(),
        builder: (context, Box<FuelEntry> box, _) {
          if (box.values.length < 2) {
            return const Center(
              child: Text(
                'Not enough data yet. Add at least two fuel entries to see your stats!',
              ),
            );
          }

          final entries = box.values.toList()
            ..sort((a, b) => a.date.compareTo(b.date));
          final settings = Hive.box<Settings>('settings').get('user_settings')!;
          final currency = currencies.firstWhere(
            (c) => c.code == settings.currencyCode,
            orElse: () => currencies.firstWhere((c) => c.code == 'USD'),
          );

          // Calculate Key Stats
          final totalEntries = entries.length;
          final totalSpending = entries
              .map((e) => e.totalCost ?? 0)
              .reduce((a, b) => a + b);
          final totalDistance = entries.last.odometer - entries.first.odometer;
          final totalFuel = entries
              .skip(1)
              .map((e) => e.fuelQuantity)
              .reduce((a, b) => a + b);
          final averageMileage = totalDistance / totalFuel;

          // Prepare Chart Data
          final List<FlSpot> mileageSpots = [];
          for (int i = 1; i < entries.length; i++) {
            final prevEntry = entries[i - 1];
            final currentEntry = entries[i];
            final distance = currentEntry.odometer - prevEntry.odometer;
            final mileage = distance / currentEntry.fuelQuantity;
            mileageSpots.add(FlSpot(i.toDouble(), mileage));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Key Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Entries',
                        totalEntries.toString(),
                        Icons.receipt_long,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Avg. Mileage',
                        '${averageMileage.toStringAsFixed(2)} ${settings.consumptionUnit}',
                        Icons.local_gas_station,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  'Total Spending',
                  '${currency.symbol}${totalSpending.toStringAsFixed(2)}',
                  Icons.monetization_on,
                  Colors.orange,
                  isFullWidth: true,
                ),
                const SizedBox(height: 24),

                // Mileage Trend Chart
                _buildChartCard(
                  'Mileage Trend (${settings.consumptionUnit})',
                  AspectRatio(
                    aspectRatio: 1.7,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: mileageSpots,
                            isCurved: true,
                            color: Colors.cyan,
                            barWidth: 4,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Recent Entries List
                Text(
                  'Recent Entries',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: min(5, entries.length),
                  itemBuilder: (context, index) {
                    final entry = entries[entries.length - 1 - index];
                    final vehicle = Hive.box<Vehicle>(
                      'vehicles',
                    ).get(entry.vehicleId);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: const Icon(
                          Icons.local_gas_station,
                          color: Colors.green,
                        ),
                        title: Text(vehicle?.name ?? 'Unknown Vehicle'),
                        subtitle: Text(
                          '${entry.fuelQuantity} ${settings.fuelUnit} @ ${currency.symbol}${entry.pricePerUnit?.toStringAsFixed(2)}/${settings.fuelUnit} - Odo: ${entry.odometer} ${settings.distanceUnit}',
                        ),
                        trailing: Text(
                          '${currency.symbol}${entry.totalCost?.toStringAsFixed(2)}',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    bool isFullWidth = false,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: isFullWidth
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: isFullWidth ? TextAlign.start : TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: isFullWidth ? TextAlign.start : TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }
}
