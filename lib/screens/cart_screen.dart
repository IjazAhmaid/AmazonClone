import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/user_detail_provider.dart';
import 'package:amazonclone/resources/cloude_firestore_meathod.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/cart_item.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_detail_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadyOnly: true, isBackButton: false),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CustomMainButton(
                              color: yellowColor,
                              isLoading: true,
                              onPressed: () {},
                              child: const Text('Loading'));
                        } else {
                          return CustomMainButton(
                              color: yellowColor,
                              isLoading: false,
                              onPressed: () async {
                                await CloudFirestoreMeathod().buyAllItemInCart(
                                    userDetailModels:
                                        Provider.of<UserDetailProvider>(context,
                                                listen: false)
                                            .userDetail);
                                Utlis().showSnackBar(
                                    context: context, content: "done");
                              },
                              child: Text(
                                  'Proceeds to  Buy (${snapshot.data!.docs.length}) Item'));
                        }
                      },
                    )),
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("cart")
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductModel productModel =
                              ProductModel.getModelFromJson(
                                  json: snapshot.data!.docs[index].data());
                          return CartItemWidget(product: productModel);
                        },
                      );
                    }
                  },
                ))
              ],
            ),
            const UserDetailBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
