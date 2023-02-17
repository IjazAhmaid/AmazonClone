import 'package:flutter/material.dart';

class CustomSimpleRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomSimpleRoundedButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Text(
          text,
        ),
      ),
    );
  }
}
