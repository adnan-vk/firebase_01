class BloodModel {
  String? name;
  int? phone;
  String? group;

  BloodModel({this.name, this.phone, this.group});

  factory BloodModel.fromJsoon(Map<String, dynamic> json) {
    return BloodModel(
        group: json['group'], name: json['name'], phone: json['phone']);
  }

  Map<String, dynamic> tojson() {
    return {"name": name, "phone": phone, "group": group};
  }
}
