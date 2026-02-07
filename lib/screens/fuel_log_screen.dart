import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models.dart';
import 'package:myapp/screens/add_fuel_entry_screen.dart';

class FuelLogScreen extends StatelessWidget {
  final Vehicle vehicle;

  const FuelLogScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${vehicle.name} - Fuel Log')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<FuelEntry>('fuel_entries').listenable(),
        builder: (context, Box<FuelEntry> box, _) {
          final entries = box.values
              .where((entry) => entry.vehicleId == vehicle.key)
              .toList();

          if (entries.isEmpty) {
            return const Center(
              child: Text('No fuel entries yet. Add one to get started!'),
            );
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    '${entry.fuelQuantity}L on ${DateFormat.yMMMd().format(entry.date)}',
                  ),
                  subtitle: Text(
                    'Odometer: ${entry.odometer} km\nPrice/L: \$${entry.pricePerUnit?.toStringAsFixed(2) ?? 'N/A'} | Total: \$${entry.totalCost?.toStringAsFixed(2) ?? 'N/A'}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      entry.delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFuelEntryScreen()),
          );
        },
        tooltip: 'Add Fuel Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}
