import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Medicine {
  final String name;
  final double price;
  final int quantity;
  final DateTime expiryDate;

  Medicine({
    required this.name,
    required this.price,
    required this.quantity,
    required this.expiryDate,
  });

  List<Medicine> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return Medicine(
          name: dataMap['name'],
          price: dataMap['price'],
          quantity: dataMap['quantity'],
          expiryDate: dataMap['expiryDate']);
    }).toList();
  }
}