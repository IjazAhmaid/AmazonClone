import 'dart:ui';

import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  final Color color;
  final double cost;
  const CostWidget({super.key, required this.color, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "₹",
          style: TextStyle(
              color: color,
              fontSize: 25,
              fontFeatures: const [FontFeature.superscripts()]),
        ),
        Text(
          cost.toInt().toString(),
          style: TextStyle(
              color: color, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          (cost - cost.truncate()).toString(),
          style: TextStyle(
              color: color,
              fontSize: 20,
              fontFeatures: const [FontFeature.superscripts()]),
        )
      ],
    );
  }
}
