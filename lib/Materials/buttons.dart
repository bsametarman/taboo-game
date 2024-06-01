import 'package:flutter/material.dart';
import 'package:tabu/Materials/appTheme.dart';

class Buttons {
  Widget mainPageButton(
      {required String text,
      double radius = 5,
      double width = 150,
      double height = 150,
      required VoidCallback onPressedFunction}) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              AppTheme().lightTheme().colorScheme.background),
          minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
          maximumSize:
              MaterialStateProperty.all<Size>(Size(width + 50, height + 50)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius))),
          )),
      child: Text(text),
    );
  }
}
