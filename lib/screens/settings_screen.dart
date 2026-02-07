import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:myapp/models.dart';
import 'package:myapp/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ... (Export and Clear data methods remain same)
  Future<void> _exportData() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final vehicleBox = Hive.box<Vehicle>('vehicles');
    final fuelBox = Hive.box<FuelEntry>('fuel_entries');

    List<List<dynamic>> rows = [];
    rows.add([
      'Vehicle Name',
      'Fuel Type',
      'Mileage Unit',
      'Date',
      'Odometer',
      'Fuel Quantity',
      'Price Per Unit',
      'Total Cost'
    ]);

    for (var entry in fuelBox.values) {
      final vehicle = vehicleBox.get(entry.vehicleId);
      // ... (rest of export logic)
      rows.add([
        vehicle?.name ?? 'N/A',
        vehicle?.fuelType ?? 'N/A',
        vehicle?.mileageUnit ?? 'N/A',
        entry.date.toIso8601String(),
        entry.odometer,
        entry.fuelQuantity,
        entry.pricePerUnit,
        entry.totalCost,
      ]);
    }

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/fuel_log_export.csv";
    final file = File(path);
    String csv = const ListToCsvConverter().convert(rows);
    await file.writeAsString(csv);

    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text('Data exported to $path')),
    );
  }

  void _clearData() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear All Data'),
          content: const Text(
              'Are you sure you want to delete all vehicles and fuel entries? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Clear Data', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                final navigator = Navigator.of(dialogContext);
                await Hive.box<Vehicle>('vehicles').clear();
                await Hive.box<FuelEntry>('fuel_entries').clear();
                navigator.pop();
                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('All data has been cleared.')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ValueListenableBuilder<Box<Settings>>(
        valueListenable: Hive.box<Settings>('settings').listenable(),
        builder: (context, box, _) {
          final settings = box.get('user_settings')!;

          return ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Appearance'),
                subtitle: const Text('Change the look and feel of the app'),
                leading: const Icon(Icons.palette),
              ),
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Enable or disable the dark theme'),
                secondary: const Icon(Icons.dark_mode),
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (bool value) {
                  themeProvider.toggleTheme();
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Units & Currency'),
                subtitle: const Text('Set your preferred units and currency'),
                leading: const Icon(Icons.straighten),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Fuel Unit', border: OutlineInputBorder()),
                  initialValue: settings.fuelUnit,
                  items: ['Liters', 'Gallons']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      settings.fuelUnit = value;
                      settings.save();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Distance Unit', border: OutlineInputBorder()),
                  initialValue: settings.distanceUnit,
                  items: ['Kilometers', 'Miles']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      settings.distanceUnit = value;
                      settings.save();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Consumption Unit', border: OutlineInputBorder()),
                  initialValue: settings.consumptionUnit,
                  items: ['MPG', 'L/100km', 'km/L']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      settings.consumptionUnit = value;
                      settings.save();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Currency', border: OutlineInputBorder()),
                  initialValue: settings.currencyCode,
                  items: currencies
                      .map((currency) => DropdownMenuItem(
                            value: currency.code,
                            child: Text('${currency.name} (${currency.symbol})'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      settings.currencyCode = value;
                      settings.save();
                    }
                  },
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Data Management'),
                subtitle: const Text('Export or clear your data'),
                leading: const Icon(Icons.storage),
              ),
              ListTile(
                title: const Text('Export to CSV'),
                subtitle: const Text('Save all your data to a CSV file'),
                leading: const Icon(Icons.download),
                onTap: _exportData,
              ),
              ListTile(
                title: const Text('Clear All Data'),
                subtitle: const Text('Permanently delete all entries'),
                leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                onTap: _clearData,
              ),
            ],
          );
        },
      ),
    );
  }
}
