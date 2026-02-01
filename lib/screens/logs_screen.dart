import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/edit_fuel_entry_screen.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  LogsScreenState createState() => LogsScreenState();
}

class LogsScreenState extends State<LogsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _deleteEntry(BuildContext context, FuelEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Entry'),
          content: const Text('Are you sure you want to delete this fuel entry?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                entry.delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editEntry(BuildContext context, FuelEntry entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFuelEntryScreen(entry: entry),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Logs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by vehicle or date',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<FuelEntry>('fuel_entries').listenable(),
              builder: (context, Box<FuelEntry> box, _) {
                var entries = box.values.toList().cast<FuelEntry>();
                entries.sort((a, b) => b.date.compareTo(a.date));

                final searchQuery = _searchController.text.toLowerCase();
                if (searchQuery.isNotEmpty) {
                  entries = entries.where((entry) {
                    final vehicle = Hive.box<Vehicle>('vehicles').get(entry.vehicleId);
                    final vehicleName = vehicle?.name.toLowerCase() ?? '';
                    final date = DateFormat.yMMMd().format(entry.date).toLowerCase();
                    return vehicleName.contains(searchQuery) || date.contains(searchQuery);
                  }).toList();
                }

                if (entries.isEmpty) {
                  return const Center(child: Text('No entries found.'));
                }

                return ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final vehicle = Hive.box<Vehicle>('vehicles').get(entry.vehicleId);

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.receipt, size: 40, color: Colors.blueAccent),
                        title: Text(DateFormat.yMMMd().format(entry.date)),
                        subtitle: Text(
                          '${vehicle?.name ?? 'N/A'}: ${entry.fuelQuantity} L at \$${entry.pricePerUnit?.toStringAsFixed(2)} - Odo: ${entry.odometer} km',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.grey),
                              onPressed: () => _editEntry(context, entry),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _deleteEntry(context, entry),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
