import 'package:amazonclone/screens/result_screen.dart';
import 'package:amazonclone/utlis/constant.dart';

import 'package:flutter/material.dart';

class CatagoresHorizentalListViewBar extends StatelessWidget {
  const CatagoresHorizentalListViewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ResultScreen(query: categoriesList[index]),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(categoryLogos[index]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(categoriesList[index]),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
