import 'package:flutter/material.dart';

class TextFields {
  Widget textField(
      {required String text,
      String hintText = "",
      double borderRadius = 5,
      //required TextEditingController textController,
      Function(String)? onChanged}) {
    return TextField(
      //controller: textController,
      decoration: InputDecoration(
        //prefixIcon: Icon(Icons.search),
        //suffixIcon: Icon(Icons.clear),
        labelText: text,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        //filled: true,
      ),
      onChanged: onChanged,
    );
  }
}
