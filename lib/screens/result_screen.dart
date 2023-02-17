import 'package:amazonclone/widgets/loading_widget.dart';
import 'package:amazonclone/widgets/result_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadyOnly: false, isBackButton: true),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Showing Result for ",
                    style: TextStyle(fontSize: 15, color: Colors.black)),
                TextSpan(
                    text: query,
                    style: const TextStyle(
                        fontSize: 15, fontStyle: FontStyle.italic))
              ])),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('products')
                .where('productName', isGreaterThanOrEqualTo: query)
                .get(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else {
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 4,
                            childAspectRatio: 2 / 3,
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      ProductModel productModel = ProductModel.getModelFromJson(
                          json: snapshot.data!.docs[index].data());
                      return ResultWidget(product: productModel);
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
