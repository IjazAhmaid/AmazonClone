import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:flutter/material.dart';

class ProductShowcaseListView extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductShowcaseListView(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utlis().getScreenSize();
    double titleHeight = 25;
    double height = screenSize.height / 4;
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(6),
      width: screenSize.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Show more",
                    style: TextStyle(color: activeCyanColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height - (titleHeight + 16),
            width: screenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          )
        ],
      ),
    );
  }
}
