import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/models/review_model.dart';
import 'package:amazonclone/resources/cloude_firestore_meathod.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/cost_widget.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/custom_simple_rounded_button.dart';
import 'package:amazonclone/widgets/ratting_star_widget.dart';
import 'package:amazonclone/widgets/review_dialog.dart';
import 'package:amazonclone/widgets/review_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_detail_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_detail_provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({super.key, required this.productModel});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    Expanded sizedBox = Expanded(
      child: Container(),
    );
    Size secreenSize = Utlis().getScreenSize();
    return SafeArea(
        child: Scaffold(
      appBar: SearchBarWidget(isReadyOnly: true, isBackButton: true),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height:
                      secreenSize.height - (kAppBarHeight + kAppBarHeight / 2),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kAppBarHeight / 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    widget.productModel.sellerName,
                                    style: const TextStyle(
                                        color: activeCyanColor, fontSize: 15),
                                  ),
                                ),
                                Text(
                                  widget.productModel.productName,
                                )
                              ],
                            ),
                            RatingStarWidget(
                                ratting: widget.productModel.ratting)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                            constraints: BoxConstraints(
                                maxHeight: secreenSize.height / 3),
                            height: secreenSize.height / 3,
                            child: Image.network(widget.productModel.url)),
                      ),
                      sizedBox,
                      Center(
                          child: CostWidget(
                              color: Colors.black,
                              cost: widget.productModel.cost)),
                      sizedBox,
                      CustomMainButton(
                        color: Colors.orange,
                        isLoading: false,
                        onPressed: () async {
                          await CloudFirestoreMeathod().addProductToOrder(
                              model: widget.productModel,
                              userDetailModels: Provider.of<UserDetailProvider>(
                                      context,
                                      listen: false)
                                  .userDetail);
                          Utlis().showSnackBar(
                              context: context, content: "You Buy It");
                        },
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      sizedBox,
                      CustomMainButton(
                        color: yellowColor,
                        isLoading: false,
                        onPressed: () async {
                          await CloudFirestoreMeathod().addProductToCart(
                              productModel: widget.productModel);
                          Utlis().showSnackBar(
                              context: context,
                              content: "Product Added to cart");
                        },
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      sizedBox,
                      CustomSimpleRoundedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ReviewDialog(
                                      productUid: widget.productModel.uid,
                                    ));
                          },
                          text: 'Add Review to this Product')
                    ],
                  ),
                ),
                SizedBox(
                    height: secreenSize.height,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .doc(widget.productModel.uid)
                          .collection('reviews')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              ReviewModel model = ReviewModel.getModelFromJson(
                                  json: snapshot.data!.docs[index].data());
                              return ReviewWidget(review: model);
                            },
                          );
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
        const UserDetailBar(
          offset: 0,
        )
      ]),
    ));
  }
}
