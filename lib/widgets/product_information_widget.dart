import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const ProductInformationWidget(
      {super.key,
      required this.productName,
      required this.cost,
      required this.sellerName});

  @override
  Widget build(BuildContext context) {
    SizedBox abc = const SizedBox(
      height: 7,
    );
    Size screensize = Utlis().getScreenSize();
    return SizedBox(
      width: screensize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            productName,
            maxLines: 2,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 17,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600),
          ),
          abc,
          Align(
            alignment: Alignment.centerLeft,
            child: CostWidget(color: Colors.black, cost: cost),
          ),
          abc,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Sold by ",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              TextSpan(
                  text: sellerName,
                  style: const TextStyle(color: activeCyanColor, fontSize: 14))
            ])),
          )
        ],
      ),
    );
  }
}
