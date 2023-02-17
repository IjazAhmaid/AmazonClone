import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/resources/cloude_firestore_meathod.dart';
import 'package:amazonclone/screens/product_screen.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/custom_sequare_button.dart';
import 'package:amazonclone/widgets/custom_simple_rounded_button.dart';
import 'package:amazonclone/widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screensize = Utlis().getScreenSize();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: screensize.height / 2,
          width: screensize.width,
          decoration: const BoxDecoration(
              color: backgroundColor,
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductScreen(productModel: product),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screensize.width / 3,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Center(
                              child: Image.network(product.url),
                            ),
                          ),
                        ),
                        ProductInformationWidget(
                            productName: product.productName,
                            cost: product.cost,
                            sellerName: product.sellerName),
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    CustomSequareButton(
                        color: backgroundColor,
                        onPressed: () {},
                        dimension: 40,
                        child: const Icon(Icons.remove)),
                    CustomSequareButton(
                        color: Colors.white,
                        onPressed: () {},
                        dimension: 40,
                        child: const Text(
                          '0',
                          style: TextStyle(color: activeCyanColor),
                        )),
                    CustomSequareButton(
                        color: backgroundColor,
                        onPressed: () async {
                          await CloudFirestoreMeathod().addProductToCart(
                              productModel: ProductModel(
                                  noOfratting: product.noOfratting,
                                  ratting: product.ratting,
                                  sellerUid: product.sellerUid,
                                  sellerName: product.sellerName,
                                  url: product.url,
                                  productName: product.productName,
                                  cost: product.cost,
                                  discount: product.discount,
                                  uid: Utlis().getUid()));
                        },
                        dimension: 40,
                        child: const Icon(Icons.add)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          CustomSimpleRoundedButton(
                              onPressed: () async {
                                CloudFirestoreMeathod()
                                    .deleteProductFromCart(uid: product.uid);
                                Utlis().showSnackBar(
                                    context: context,
                                    content: 'Product Deleted From Cart');
                              },
                              text: "Delete"),
                          const SizedBox(
                            width: 7,
                          ),
                          CustomSimpleRoundedButton(
                            onPressed: () {},
                            text: "Save for Latter",
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'See More Like This',
                            style: TextStyle(color: activeCyanColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
