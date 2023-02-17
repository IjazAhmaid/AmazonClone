class UserDetailModels {
  final String name;
  final String address;
  UserDetailModels({
    required this.name,
    required this.address,
  });
  Map<String, dynamic> getJson() => {'name': name, 'address': address};

  factory UserDetailModels.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailModels(name: json["name"], address: json["address"]);
  }
}
