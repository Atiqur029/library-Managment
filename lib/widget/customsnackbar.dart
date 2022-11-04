import 'package:flutter/material.dart';

class CustomSnacbar {
  final bool isWrning;
  CustomSnacbar({
    required this.isWrning,
  });

  snackbarMassege(BuildContext context, String messege) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      messege,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          backgroundColor: isWrning ? Colors.red : Colors.green),
    )));
  }
}
