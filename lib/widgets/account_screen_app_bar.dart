import 'package:amazonclone/screens/search_screen.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:flutter/material.dart';

import '../utlis/color_theme.dart';

class AccountgScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AccountgScreenAppBar({super.key})
      : preferredSize = const Size.fromHeight(kAppBarHeight);
  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    Size screensize = Utlis().getScreenSize();
    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        width: screensize.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: backgroundGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.network(
                amazonLogoUrl,
                height: kAppBarHeight * 0.7,
              ),
            ),
            Row(children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ));
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                  ))
            ])
          ],
        ),
      ),
    );
  }
}
