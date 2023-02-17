import 'package:flutter/material.dart';

class CustomSequareButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final Widget child;
  final double dimension;
  const CustomSequareButton(
      {super.key,
      required this.color,
      required this.onPressed,
      required this.child,
      required this.dimension});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: dimension,
        width: dimension,
        decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(2))),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
