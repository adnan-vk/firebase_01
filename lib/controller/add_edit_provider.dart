import 'package:flutter/material.dart';
import 'package:practice/model/model.dart';
import 'package:practice/service/service.dart';

class AddEditProvider extends ChangeNotifier{
  DbService dbService = DbService();
  List listItems = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  var selectedgroup = "A+";

  Future AddDonor(BloodModel data)async{
    await dbService.donor.add(data);
    notifyListeners();
  }
}