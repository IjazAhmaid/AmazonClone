import 'package:amazonclone/models/user_detail_model.dart';
import 'package:amazonclone/resources/cloude_firestore_meathod.dart';
import 'package:flutter/material.dart';

class UserDetailProvider with ChangeNotifier {
  UserDetailModels userDetail;
  UserDetailProvider()
      : userDetail = UserDetailModels(name: "loading", address: "loading");
  Future getData() async {
    userDetail = await CloudFirestoreMeathod().getNameAndAddress();
    notifyListeners();
  }
}
