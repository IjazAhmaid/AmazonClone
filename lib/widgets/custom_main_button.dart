import 'package:amazonclone/utlis/utlis.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomMainButton(
      {super.key,
      required this.child,
      required this.color,
      required this.isLoading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utlis().getScreenSize();
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color, fixedSize: Size(screenSize.width * .6, 40)),
        onPressed: onPressed,
        child: !isLoading
            ? child
            : const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ));
  }
}
