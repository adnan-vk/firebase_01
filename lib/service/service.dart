import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/model/model.dart';

class DbService {
  String crud = "donor";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference<BloodModel> donor;

  DbService() {
    donor = firestore.collection(crud).withConverter<BloodModel>(
        fromFirestore: (snapshot, _) => BloodModel.fromJsoon(snapshot.data()!),
        toFirestore: (data, _) => data.tojson());
  }
}
