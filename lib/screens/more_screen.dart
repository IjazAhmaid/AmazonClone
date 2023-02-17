import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/widgets/catagory_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(isReadyOnly: true, isBackButton: false),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.2 / 3.5,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) => CatagoryWidget(index: index)),
        ));
  }
}
