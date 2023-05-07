import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditEmployeeScreen extends StatefulWidget {
  final String employeeId;
  final String employeeName;
  final String employeeSalary;
  final String employeePhone;

  EditEmployeeScreen({
    required this.employeeId,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeePhone,
  });

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _salaryController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.employeeName;
    _salaryController.text = widget.employeeSalary;
    _phoneController.text = widget.employeePhone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('EDIT EMPLOYEE', style: TextStyle(fontWeight: FontWeight.bold)),
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

            // Text input for price
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(
                labelText: 'Salary',
              ),
            ),
            SizedBox(height: 16),

            // Text input for quantity
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
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

  void _saveData() async {
    // Get the input values from the text editing controllers
    String name = _nameController.text.trim();
    String salary = _salaryController.text.trim();
    String phone = _phoneController.text.trim();

    // Update the document in the 'medicines' collection with the new values
    await _firestore
        .collection('employee')
        .doc(widget.employeeId)
        .update({
      'name': name,
      'salary': salary,
      'phone': phone,
    });

    // Show a snackbar to indicate that the data has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully')),
    );

    // Navigate back to the previous screen
    Navigator.pop(context);
  }
}
