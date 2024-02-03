import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/model/model.dart';
import 'package:practice/service/service.dart';

class HomeProvider extends ChangeNotifier {
  DbService dbService = DbService();
  Stream<QuerySnapshot<BloodModel>> getdatas() {
    return dbService.donor.snapshots();
  }
}