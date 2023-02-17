import 'package:amazonclone/utlis/color_theme.dart';
import 'package:flutter/material.dart';

import '../utlis/constant.dart';

class BannerAddWidget extends StatefulWidget {
  const BannerAddWidget({super.key});

  @override
  State<BannerAddWidget> createState() => _BannerAddWidgetState();
}

class _BannerAddWidgetState extends State<BannerAddWidget> {
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSzie = MediaQuery.of(context).size;
    double smallAddheight = screenSzie.width / 3.4;

    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAd == (largeAds.length - 1)) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                largeAds[currentAd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 100,
                  width: screenSzie.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0)
                      ])),
                ),
              )
            ],
          ),
          Container(
            height: smallAddheight,
            width: screenSzie.width,
            color: backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: getSmallAdsFromIndex(0, smallAddheight)),
                Expanded(child: getSmallAdsFromIndex(1, smallAddheight)),
                Expanded(child: getSmallAdsFromIndex(2, smallAddheight)),
                Expanded(child: getSmallAdsFromIndex(3, smallAddheight))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getSmallAdsFromIndex(int index, double height) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: height,
        width: height,
        decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 1)
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(smallAds[index]),
                const SizedBox(
                  height: 4,
                ),
                Text(adItemNames[index])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
