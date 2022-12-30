import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;


  const MyAlertDialog({Key? key, required this.controller, required this.onSave,required this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:  TextField(
          controller:controller,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
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
