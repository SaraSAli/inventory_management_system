import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMedicineScreen extends StatefulWidget {
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _idController = new TextEditingController();


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title:
            Text('ADD MEDICINE', style: TextStyle(fontWeight: FontWeight.bold)),
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
                labelText: 'Medicine Name',
              ),
            ),
            SizedBox(height: 16),

            // Text input for phone
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
            ),
            SizedBox(height: 16),

            // Text input for medicines
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID',
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
    String quantity = _quantityController.text.trim();
    String price = _priceController.text.trim();
    String id = _idController.text.trim();

    // Create a new document in the 'companies' collection with the input values
    _firestore.collection('medicine').doc(id).set({
      'name': name,
      'quantity': quantity,
      'price': price,
      'expiryDate': DateTime.now(),
    });

    // Clear the input fields
    _nameController.clear();
    _quantityController.clear();
    _priceController.clear();

    // Show a snackbar to indicate that the data has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully')),
    );

    Navigator.pop(context);

  }
}
