// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todomithive/widgets/buttons.dart';

class AddTaskDialog extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  AddTaskDialog({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 30.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Texteingabefeld für neue Aufgabe
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Neue Aufgabe hinzufügen",
              ),
            ),

            // Reihe für speichern und abbrechen
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // speichern
                AlertDialogButton(text: "speichern", onPressed: onSave),

                const SizedBox(width: 8),

                // abbrechen
                AlertDialogButton(text: "abbrechen", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
