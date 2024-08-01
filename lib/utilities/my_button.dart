import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Mybutton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  Mybutton({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.yellow,
      child : Text(text),
    );
  }
}