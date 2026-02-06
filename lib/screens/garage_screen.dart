import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: vehicle.imagePath != null && vehicle.imagePath!.isNotEmpty
                        ? Image.file(File(vehicle.imagePath!))
                        : Image.asset('assets/images/placeholder.png'),
                  ),
                  title: Text(vehicle.name, style: Theme.of(context).textTheme.titleLarge),
                  subtitle: Text(
                      '${vehicle.make ?? ''} ${vehicle.model ?? ''} (${vehicle.year?.toString() ?? ''})\n${vehicle.fuelType} | ${vehicle.mileageUnit}'),
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
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _licensePlateController = TextEditingController();
  String _fuelType = 'Gasoline';
  String _mileageUnit = 'Kilometers';
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Vehicle'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _imageFile == null
                  ? const Text('No image selected.')
                  : Image.file(File(_imageFile!.path)),
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Select Image'),
                onPressed: _pickImage,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Vehicle Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _makeController,
                decoration: const InputDecoration(labelText: 'Make'),
              ),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _licensePlateController,
                decoration: const InputDecoration(labelText: 'License Plate'),
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
                ..make = _makeController.text
                ..model = _modelController.text
                ..year = int.tryParse(_yearController.text)
                ..licensePlate = _licensePlateController.text
                ..fuelType = _fuelType
                ..mileageUnit = _mileageUnit
                ..imagePath = _imageFile?.path;

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
