import 'package:amazonclone/models/review_model.dart';
import 'package:amazonclone/provider/user_detail_provider.dart';
import 'package:amazonclone/resources/cloude_firestore_meathod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({super.key, required this.productUid});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        'Type Review to this Product',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      submitButtonText: 'Send',
      commentHint: 'Type Here',
      onSubmitted: (RatingDialogResponse res) async {
        CloudFirestoreMeathod().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                senderName:
                    Provider.of<UserDetailProvider>(context, listen: false)
                        .userDetail
                        .name,
                description: res.comment,
                ratting: res.rating.toInt()));
        // print(res.rating);
        // print(res.comment);
      },
    );
  }
}
