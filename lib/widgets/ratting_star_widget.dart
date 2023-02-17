import 'package:flutter/material.dart';

class RatingStarWidget extends StatelessWidget {
  final int ratting;
  const RatingStarWidget({super.key, required this.ratting});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < 5; i++) {
      children.add(
        i < ratting
            ? const SizedBox(
                width: 20,
                child: Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
              )
            : const SizedBox(
                width: 20,
                child: Icon(Icons.star_border, color: Colors.orange)),
      );
    }
    return Row(
      children: children,
    );
  }
}
