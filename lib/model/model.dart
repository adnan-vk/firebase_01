class BloodModel {
  String? name;
  int? phone;
  int? age;
  String? group;

  BloodModel({this.name, this.phone, this.group, this.age});

  factory BloodModel.fromJsoon(Map<String, dynamic> json) {
    return BloodModel(
        group: json['group'],
        name: json['name'],
        phone: json['phone'],
        age: json['age']);
  }

  Map<String, dynamic> tojson() {
    return {"name": name, "phone": phone, "group": group, "age": age};
  }
}
