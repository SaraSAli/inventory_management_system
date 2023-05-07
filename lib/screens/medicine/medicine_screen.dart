import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/medicine.dart';
import 'add_medicine_screen.dart';
import 'edit_medicine_screen.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {

  final Stream<QuerySnapshot> _medicineStream = FirebaseFirestore.instance
      .collection('medicine')
      .snapshots();

  final List<Medicine> _medicines = [
    Medicine(
      name: 'Paracetamol',
      price: 2.99,
      quantity: 30,
      expiryDate: DateTime(2023, 12, 31),
    ),
    Medicine(
      name: 'Ibuprofen',
      price: 4.99,
      quantity: 20,
      expiryDate: DateTime(2022, 10, 15),
    ),
    Medicine(
      name: 'Aspirin',
      price: 1.99,
      quantity: 50,
      expiryDate: DateTime(2024, 6, 30),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          IconButton(
              icon: Icon(Icons.add_circle, size: 32),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddMedicineScreen()));
              })
        ],
        title: Text('Medicines'),
      ),
      body: StreamBuilder(
        stream: _medicineStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditMedicineScreen(
                              medicineId: snapshot.data!.docChanges[index].doc['id'],
                                medicineName: snapshot.data!.docChanges[index].doc['name'],
                                medicinePrice: snapshot.data!.docChanges[index].doc['price'],
                                medicineQuantity: snapshot.data!.docChanges[index].doc['quantity'])));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['name'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: \$${snapshot.data!.docChanges[index].doc['price']}'),
                              Text('Quantity: ${snapshot.data!.docChanges[index].doc['quantity']}'),
                              Text('Expiry Date: ${snapshot.data!.docChanges[index].doc['expiryDate'].toDate().toString()}'),
                            ],
                          ),
                          trailing: Icon(Icons.edit),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
