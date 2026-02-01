
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models.dart';

class AddFuelEntryScreen extends StatefulWidget {
  const AddFuelEntryScreen({super.key});

  @override
  _AddFuelEntryScreenState createState() => _AddFuelEntryScreenState();
}

class _AddFuelEntryScreenState extends State<AddFuelEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _odometerController = TextEditingController();
  final _fuelQuantityController = TextEditingController();
  final _pricePerUnitController = TextEditingController();
  final _totalCostController = TextEditingController();

  late DateTime _selectedDate;
  Vehicle? _selectedVehicle;
  List<Vehicle> _vehicles = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _vehicles = Hive.box<Vehicle>('vehicles').values.toList();
    // Initialize with a default vehicle if available
    if (_vehicles.isNotEmpty) {
      _selectedVehicle = _vehicles.first;
    }

    // Add listeners to auto-calculate total cost
    _fuelQuantityController.addListener(_calculateTotalCost);
    _pricePerUnitController.addListener(_calculateTotalCost);
  }

  void _calculateTotalCost() {
    final fuelQuantity = double.tryParse(_fuelQuantityController.text) ?? 0.0;
    final pricePerUnit = double.tryParse(_pricePerUnitController.text) ?? 0.0;
    final totalCost = fuelQuantity * pricePerUnit;
    _totalCostController.text = totalCost.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _odometerController.dispose();
    _fuelQuantityController.dispose();
    _pricePerUnitController.dispose();
    _totalCostController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      if (_selectedVehicle == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add a vehicle in the garage first.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final newEntry = FuelEntry()
        ..vehicleId = _selectedVehicle!.key
        ..date = _selectedDate
        ..odometer = double.parse(_odometerController.text)
        ..fuelQuantity = double.parse(_fuelQuantityController.text)
        ..pricePerUnit = double.tryParse(_pricePerUnitController.text)
        ..totalCost = double.tryParse(_totalCostController.text);

      Hive.box<FuelEntry>('fuel_entries').add(newEntry);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Fuel Entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveEntry,
            tooltip: 'Save Entry',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Vehicle Dropdown
              DropdownButtonFormField<Vehicle>(
                value: _selectedVehicle,
                decoration: const InputDecoration(
                  labelText: 'Vehicle',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_car),
                ),
                items: _vehicles.map((Vehicle vehicle) {
                  return DropdownMenuItem<Vehicle>(
                    value: vehicle,
                    child: Text(vehicle.name),
                  );
                }).toList(),
                onChanged: (Vehicle? newValue) {
                  setState(() {
                    _selectedVehicle = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a vehicle' : null,
              ),
              const SizedBox(height: 16),

              // Odometer Reading
              TextFormField(
                controller: _odometerController,
                decoration: const InputDecoration(
                  labelText: 'Odometer Reading',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.speed),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the odometer reading';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Fuel Quantity
              TextFormField(
                controller: _fuelQuantityController,
                decoration: const InputDecoration(
                  labelText: 'Fuel Quantity (e.g., Liters)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_gas_station),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the fuel quantity';
                  }
                   if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Price Per Unit
              TextFormField(
                controller: _pricePerUnitController,
                decoration: const InputDecoration(
                  labelText: 'Price Per Unit',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),

              // Total Cost (Read-only)
              TextFormField(
                controller: _totalCostController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Total Cost',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.price_check),
                ),
              ),
              const SizedBox(height: 16),

              // Date Picker
              ListTile(
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                leading: const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Icon(Icons.calendar_today),
                ),
                title: Text(
                  'Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                ),
                trailing: const Icon(Icons.arrow_drop_down),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 24),

              // Save Button
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Entry'),
                onPressed: _saveEntry,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
