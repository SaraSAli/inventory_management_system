import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({Key? key}) : super(key: key);

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('ADD COMPANY', style: TextStyle(fontWeight: FontWeight.bold)),
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
                labelText: 'Company Name',
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
    String medicine = '';
    List<String> myList = [];
    myList.add(medicine);

    // Create a new document in the 'companies' collection with the input values
    _firestore.collection('company').add({
      'name': name,
      'phone': phone,
      'medicine': myList,
    });

    // Clear the input fields
    _nameController.clear();
    _phoneController.clear();

    // Show a snackbar to indicate that the data has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully')),
    );

    Navigator.pop(context);
  }
}
