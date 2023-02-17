import 'dart:typed_data';

import 'package:amazonclone/models/order_request_model.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/models/review_model.dart';
import 'package:amazonclone/models/user_detail_model.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudFirestoreMeathod {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future uploadNameAndAddressToDatabase(
      {required UserDetailModels user}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserDetailModels userModels =
        UserDetailModels.getModelFromJson((snap.data() as dynamic));

    return userModels;
  }

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something went wrong";
    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = Utlis().getUid();
        String url = await uploadImageToDtatabase(image: image, uid: uid);
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));
        ProductModel product = ProductModel(
            noOfratting: 0,
            ratting: 4,
            sellerUid: sellerUid,
            sellerName: sellerName,
            url: url,
            productName: productName,
            cost: cost,
            discount: discount,
            uid: uid);
        await firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getjson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make shure to fill all the filed";
    }
    return output;
  }

  Future<String> uploadImageToDtatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel product =
          ProductModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(SimpleProductWidget(productModel: product));
    }
    return children;
  }

  Future uploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    await firebaseFirestore
        .collection('products')
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
    await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(productModel.uid)
        .set(productModel.getjson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(uid)
        .delete();
  }

  Future buyAllItemInCart({required UserDetailModels userDetailModels}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel model =
          ProductModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrder(model: model, userDetailModels: userDetailModels);

      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrder(
      {required ProductModel model,
      required UserDetailModels userDetailModels}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getjson());
    await sendOrderRequest(model: model, userDetailModels: userDetailModels);
  }

  Future sendOrderRequest({
    required ProductModel model,
    required UserDetailModels userDetailModels,
  }) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        ordername: model.productName, byerAddress: userDetailModels.address);
    await firebaseFirestore
        .collection('users')
        .doc(model.sellerUid)
        .collection('orderRequests')
        .add(orderRequestModel.getjson());
  }

  Future changeAverageRating(
      {required String productUid, required ReviewModel reviewModel}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection('products').doc(productUid).get();
    ProductModel productModel =
        ProductModel.getModelFromJson(json: (snapshot.data() as dynamic));
    int currentRating = productModel.ratting;
    int newratting = (currentRating + reviewModel.ratting) ~/ 2;
    await firebaseFirestore
        .collection('products')
        .doc(productUid)
        .update({'rating': newratting});
  }
}
