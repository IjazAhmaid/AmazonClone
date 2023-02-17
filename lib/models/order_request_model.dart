class OrderRequestModel {
  final String ordername;
  final String byerAddress;
  OrderRequestModel({
    required this.ordername,
    required this.byerAddress,
  });
  Map<String, dynamic> getjson() =>
      {'ordername': ordername, 'byerAddress': byerAddress};

  factory OrderRequestModel.getModelFromjson(
      {required Map<String, dynamic> json}) {
    return OrderRequestModel(
        ordername: json['ordername'], byerAddress: json['byerAddress']);
  }
}
