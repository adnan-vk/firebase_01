import 'package:flutter/material.dart';
import 'package:practice/model/model.dart';
import 'package:practice/service/service.dart';

class AddEditProvider extends ChangeNotifier {
  DbService dbService = DbService();
  List listItems = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  var selectedgroup = "A+";

  Future addDonor(BloodModel data) async {
    await dbService.donor.add(data);
    notifyListeners();
  }

 Future updatedonor(BloodModel donors, [String? id]) async {
    dbService.donor.doc(id).update(donors.tojson());
    notifyListeners();
  }

 void delete(id){
    dbService.donor.doc(id).delete();
    notifyListeners();
  }
}
