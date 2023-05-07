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
}