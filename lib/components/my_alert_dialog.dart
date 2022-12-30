import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;


  const MyAlertDialog({Key? key, required this.controller, required this.onSave,required this.onCancel, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:  TextField(
          controller:controller,
        decoration:  InputDecoration(
          hintText: hintText ,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.grey[800],
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.grey[800],
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
