class BloodModel {
  String? name;
  int? phone;
  int? age;
  String? group;
  String? image;

  BloodModel({this.name, this.phone, this.group, this.age, this.image});

  factory BloodModel.fromJsoon(Map<String, dynamic> json) {
    return BloodModel(
        group: json['group'],
        name: json['name'],
        phone: json['phone'],
        age: json['age'],
        image: json['image']);
  }

  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "phone": phone,
      "group": group,
      "age": age,
      "image": image
    };
  }
}
