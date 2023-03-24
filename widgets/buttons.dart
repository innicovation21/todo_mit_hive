import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  
  AddButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}
