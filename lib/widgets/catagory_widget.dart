import 'package:amazonclone/screens/result_screen.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:flutter/material.dart';

class CatagoryWidget extends StatelessWidget {
  final int index;
  const CatagoryWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(query: categoriesList[index]),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.2))
            ]),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(categoryLogos[index]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categoriesList[index],
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, letterSpacing: 0.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
