import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app/utilities/my_button.dart';

// ignore: must_be_immutable
class DailogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DailogBox({super.key,required this.controller,required this.onSave,required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content : Container(
        height : 150,
        child :Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          TextField(
            controller: controller ,
            decoration: InputDecoration(border: OutlineInputBorder(),
            hintText: 'Add a new task ',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Mybutton(text: "Save", onPressed: onSave),
            const SizedBox(width:5),
            Mybutton(text: "Cancel", onPressed: onCancel)
          ],)
        ],)
      )
    );
  }
}