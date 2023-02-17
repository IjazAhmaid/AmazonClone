import 'package:amazonclone/screens/result_screen.dart';
import 'package:amazonclone/screens/search_screen.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isReadyOnly;
  final bool isBackButton;
  SearchBarWidget({
    super.key,
    required this.isReadyOnly,
    required this.isBackButton,
  }) : preferredSize = const Size.fromHeight(kAppBarHeight);

  @override
  final Size preferredSize;
  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(color: Colors.grey, width: 1));

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utlis().getScreenSize();
    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        // color: Colors.amberAccent,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: backgroundGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isBackButton
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  )
                : Container(),
            SizedBox(
              width: screenSize.width * 0.7,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 5))
                ]),
                child: TextField(
                  onSubmitted: (query) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(query: query)));
                  },
                  readOnly: isReadyOnly,
                  onTap: () {
                    if (isReadyOnly) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SearchScreen();
                        },
                      ));
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Search Somthing on Amazon",
                      border: border,
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: border),
                ),
              ),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.mic_none_outlined)),
          ],
        ),
      ),
    );
  }
}
