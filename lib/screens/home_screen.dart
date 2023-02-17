import 'package:amazonclone/resources/cloude_firestore_meathod.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/widgets/banner_add_widget.dart';
import 'package:amazonclone/widgets/catagories_horizental_list_view_bar.dart';
import 'package:amazonclone/widgets/loading_widget.dart';
import 'package:amazonclone/widgets/products_show_case_list_view.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_detail_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;
  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
      // print(controller.position.pixels);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  getData() async {
    List<Widget> temp70 =
        await CloudFirestoreMeathod().getProductFromDiscount(70);
    List<Widget> temp60 =
        await CloudFirestoreMeathod().getProductFromDiscount(60);
    List<Widget> temp50 =
        await CloudFirestoreMeathod().getProductFromDiscount(50);
    List<Widget> temp0 =
        await CloudFirestoreMeathod().getProductFromDiscount(0);
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(isReadyOnly: true, isBackButton: false),
        body: discount70 != null &&
                discount60 != null &&
                discount50 != null &&
                discount0 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: kAppBarHeight / 2,
                        ),
                        const CatagoresHorizentalListViewBar(),
                        const BannerAddWidget(),
                        ProductShowcaseListView(
                            title: 'Upto 70% off', children: discount70!),
                        ProductShowcaseListView(
                            title: 'Upto 60% off', children: discount60!),
                        ProductShowcaseListView(
                            title: 'Upto 50% off', children: discount50!),
                        ProductShowcaseListView(
                            title: 'Explore', children: discount0!)
                      ],
                    ),
                  ),
                  UserDetailBar(
                    offset: offset,
                  )
                ],
              )
            : const LoadingWidget());
  }
}
