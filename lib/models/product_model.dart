class ProductModel {
  final String url;
  final String productName;
  final double cost;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int ratting;
  final int noOfratting;
  ProductModel({
    required this.noOfratting,
    required this.ratting,
    required this.sellerUid,
    required this.sellerName,
    required this.url,
    required this.productName,
    required this.cost,
    required this.discount,
    required this.uid,
  });
  Map<String, dynamic> getjson() {
    return {
      "noOfratting": noOfratting,
      "ratting": ratting,
      "sellerUid": sellerUid,
      "sellerName": sellerName,
      "url": url,
      "productName": productName,
      "cost": cost,
      "discount": discount,
      "uid": uid
    };
  }

  factory ProductModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ProductModel(
        noOfratting: json["noOfratting"],
        ratting: json['ratting'],
        sellerUid: json['sellerUid'],
        sellerName: json['sellerName'],
        url: json['url'],
        productName: json['productName'],
        cost: json['cost'],
        discount: json['discount'],
        uid: json['uid']);
  }
}
