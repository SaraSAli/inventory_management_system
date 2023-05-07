import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _salaryController = new TextEditingController();
  TextEditingController _nationalIdController = new TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('ADD EMPLOYEE', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text input for name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Employee Name',
              ),
            ),
            SizedBox(height: 16),

            // Text input for phone
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 16),

            // Text input for medicines
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(
                labelText: 'Salary',
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: _nationalIdController,
              decoration: InputDecoration(
                labelText: 'National ID',
              ),
            ),
            SizedBox(height: 16),

            // Button to save data to Firestore
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to save data to Firestore
  void _saveData() {
    // Get the input values from the text editing controllers
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();
    String salary = _salaryController.text.trim();
    String id = _nationalIdController.text.trim();

    // Create a new document in the 'companies' collection with the input values
    _firestore.collection('employee').doc(id).set({
      'name': name,
      'phone': phone,
      'salary': salary,
      'nationalId': id,
    });

    // Show a snackbar to indicate that the data has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully')),
    );

    Navigator.pop(context);
  }
}
