import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:myapp/models.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _exportData(BuildContext context) async {
    final vehicleBox = Hive.box<Vehicle>('vehicles');
    final fuelBox = Hive.box<FuelEntry>('fuel_entries');

    List<List<dynamic>> rows = [];
    rows.add(['Vehicle Name', 'Fuel Type', 'Mileage Unit', 'Date', 'Odometer', 'Fuel Quantity', 'Price Per Unit', 'Total Cost']);

    for (var entry in fuelBox.values) {
      final vehicle = vehicleBox.get(entry.vehicleId);
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

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data exported to $path')),
    );
  }

  void _clearData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Data'),
          content: const Text('Are you sure you want to delete all vehicles and fuel entries? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Clear Data', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await Hive.box<Vehicle>('vehicles').clear();
                await Hive.box<FuelEntry>('fuel_entries').clear();
                if (!mounted) return;
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
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
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Appearance'),
            subtitle: const Text('Change the look and feel of the app'),
            leading: const Icon(Icons.palette),
            onTap: () { // Placeholder for a dedicated appearance screen if needed
            },
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
            title: const Text('Data Management'),
            subtitle: const Text('Export or clear your data'),
            leading: const Icon(Icons.storage),
            onTap: () { // Placeholder for a dedicated data management screen if needed
            },
          ),
          ListTile(
            title: const Text('Export to CSV'),
            subtitle: const Text('Save all your data to a CSV file'),
            leading: const Icon(Icons.download),
            onTap: () => _exportData(context),
          ),
          ListTile(
            title: const Text('Clear All Data'),
            subtitle: const Text('Permanently delete all entries'),
            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
            onTap: () => _clearData(context),
          ),
        ],
      ),
    );
  }
}
