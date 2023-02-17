import 'package:amazonclone/models/review_model.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/ratting_star_widget.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    Size secreensize = Utlis().getScreenSize();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.senderName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: secreensize.width / 4,
                    child: FittedBox(
                      child: RatingStarWidget(ratting: review.ratting),
                    ),
                  ),
                ),
                Text(
                  keysOfRating[review.ratting - 1],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Text(
            review.description,
            maxLines: 3,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
