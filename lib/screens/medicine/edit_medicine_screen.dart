import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditMedicineScreen extends StatefulWidget {
  final String medicineId;
  final String medicineName;
  final String medicinePrice;
  final String medicineQuantity;

  EditMedicineScreen({
    required this.medicineId,
    required this.medicineName,
    required this.medicinePrice,
    required this.medicineQuantity,
  });

  @override
  State<EditMedicineScreen> createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController();


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.medicineName;
    _priceController.text = widget.medicinePrice;
    _quantityController.text = widget.medicineQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('EDIT MEDICINE', style: TextStyle(fontWeight: FontWeight.bold)),
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

            // Text input for price
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 16),

            // Text input for quantity
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
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
    String price = _priceController.text.trim();
    String quantity = _quantityController.text.trim();

    // Update the document in the 'medicines' collection with the new values
    await _firestore
        .collection('medicine')
        .doc(widget.medicineId)
        .update({
      'name': name,
      'price': price,
      'quantity': quantity,
    });

    // Show a snackbar to indicate that the data has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully')),
    );

    // Navigate back to the previous screen
    Navigator.pop(context);
  }
}
