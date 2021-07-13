import 'package:flutter/material.dart';

BoxDecoration boxDecorationWidget(Color color) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 1.5,
            offset: Offset(1, 2))
      ]);
}
