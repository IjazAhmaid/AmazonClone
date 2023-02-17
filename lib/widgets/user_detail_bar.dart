import 'package:amazonclone/models/user_detail_model.dart';
import 'package:amazonclone/provider/user_detail_provider.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailBar extends StatelessWidget {
  final double offset;

  const UserDetailBar({
    super.key,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    Size screensize = Utlis().getScreenSize();
    UserDetailModels userDetail =
        Provider.of<UserDetailProvider>(context).userDetail;
    return Positioned(
      top: -offset / 3,
      child: Container(
        height: kAppBarHeight / 2,
        width: screensize.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: lightBackgroundaGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(
                width: screensize.width * 0.7,
                child: Text(
                  'Deliver to ${userDetail.name} address is ${userDetail.address}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
