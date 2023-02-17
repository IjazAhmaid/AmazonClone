import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/screens/product_screen.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/cost_widget.dart';
import 'package:amazonclone/widgets/ratting_star_widget.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel product;
  const ResultWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screensize = Utlis().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(productModel: product),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: screensize.width / 3,
                  child: Image.network(product.url)),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  product.productName,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          width: screensize.width / 4,
                          child: FittedBox(
                              child:
                                  RatingStarWidget(ratting: product.ratting))),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          product.noOfratting.toString(),
                          style: const TextStyle(color: activeCyanColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
                child: FittedBox(
                  child: CostWidget(
                      color: const Color.fromARGB(255, 92, 9, 3),
                      cost: product.cost),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
