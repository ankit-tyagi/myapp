import 'package:flutter/material.dart';

class AddFuelEntryScreen extends StatelessWidget {
  const AddFuelEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Fuel Entry'),
      ),
      body: const Center(
        child: Text('Add Fuel Entry Screen'),
      ),
    );
  }
}
