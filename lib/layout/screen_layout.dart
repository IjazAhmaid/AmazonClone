import 'package:amazonclone/provider/user_detail_provider.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pagecontroller = PageController();
  int currentpage = 0;
  @override
  void dispose() {
    super.dispose();
    pagecontroller.dispose();
  }

  changePage(int page) {
    pagecontroller.jumpToPage(page);
    setState(() {
      currentpage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pagecontroller,
              children: screens),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey[400]!, width: 1))),
            child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: activeCyanColor, width: 2))),
                onTap: changePage,
                tabs: [
                  Tab(
                    child: Icon(
                      Icons.home_outlined,
                      color: currentpage == 0 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: currentpage == 1 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: currentpage == 2 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.menu,
                      color: currentpage == 3 ? activeCyanColor : Colors.black,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
