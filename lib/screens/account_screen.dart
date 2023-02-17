import 'package:amazonclone/models/order_request_model.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/models/user_detail_model.dart';
import 'package:amazonclone/provider/user_detail_provider.dart';
import 'package:amazonclone/screens/sell_screen.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/account_screen_app_bar.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/products_show_case_list_view.dart';
import 'package:amazonclone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utlis/color_theme.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screensize = Utlis().getScreenSize();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AccountgScreenAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screensize.height,
            width: screensize.width,
            child: Column(
              children: [
                const IntroductionWidgetAccountScreen(),
                CustomMainButton(
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    'Sign out',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                CustomMainButton(
                  color: yellowColor,
                  isLoading: false,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellScreen()));
                  },
                  child: const Text(
                    'Sell',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('orders')
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      List<Widget> children = [];

                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        ProductModel model = ProductModel.getModelFromJson(
                            json: snapshot.data!.docs[i].data());
                        children.add(SimpleProductWidget(productModel: model));
                      }
                      return ProductShowcaseListView(
                          title: 'Your Order', children: children);
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Order Request",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('orderRequests')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            OrderRequestModel model =
                                OrderRequestModel.getModelFromjson(
                                    json: snapshot.data!.docs[index].data());
                            return ListTile(
                              title: Text(
                                'Order: ${model.ordername}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                              subtitle: Text('Address: ${model.byerAddress}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('orderRequests')
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Color.fromARGB(255, 247, 24, 9),
                                  )),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailModels userDetail =
        Provider.of<UserDetailProvider>(context).userDetail;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0.0007)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Helow,",
                    style: TextStyle(fontSize: 24, color: Colors.grey[800])),
                TextSpan(
                    text: " ${userDetail.name}",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold))
              ])),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 23),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://static.abplive.com/wp-content/uploads/2020/05/13042222/Aamir-Khan.jpg"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
