class ReviewModel {
  final String senderName;
  final String description;
  final int ratting;
  ReviewModel(
      {required this.senderName,
      required this.description,
      required this.ratting});

  factory ReviewModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ReviewModel(
        senderName: json['senderName'],
        description: json['description'],
        ratting: json['ratting']);
  }
  Map<String, dynamic> getJson() => {
        'senderName': senderName,
        'description': description,
        'ratting': ratting
      };
}
