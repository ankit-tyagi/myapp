import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  GarageScreenState createState() => GarageScreenState();
}

class GarageScreenState extends State<GarageScreen> {
  void _showAddVehicleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddVehicleForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Garage'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Vehicle>('vehicles').listenable(),
        builder: (context, Box<Vehicle> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No vehicles yet. Add one to get started!'),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final vehicle = box.getAt(index)!;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.directions_car, size: 40),
                  title: Text(vehicle.name, style: Theme.of(context).textTheme.titleLarge),
                  subtitle: Text('${vehicle.fuelType} | ${vehicle.mileageUnit}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      vehicle.delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddVehicleDialog,
        tooltip: 'Add Vehicle',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddVehicleForm extends StatefulWidget {
  const AddVehicleForm({super.key});

  @override
  AddVehicleFormState createState() => AddVehicleFormState();
}

class AddVehicleFormState extends State<AddVehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _fuelType = 'Gasoline';
  String _mileageUnit = 'Kilometers';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Vehicle'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Vehicle Name'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a name' : null,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Fuel Type'),
              items: ['Gasoline', 'Diesel', 'Electric', 'Hybrid']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _fuelType = value;
                  });
                }
              },
              initialValue: _fuelType,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Mileage Unit'),
              items: ['Kilometers', 'Miles']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _mileageUnit = value;
                  });
                }
              },
              initialValue: _mileageUnit,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newVehicle = Vehicle()
                ..name = _nameController.text
                ..fuelType = _fuelType
                ..mileageUnit = _mileageUnit;

              Hive.box<Vehicle>('vehicles').add(newVehicle);

              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
