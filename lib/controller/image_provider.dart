import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/service/service.dart';

class ImgProvider extends ChangeNotifier {
  final picker = ImagePicker();
  File? pickedImage;
  DbService dbService = DbService();
  String imageName = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadUrl = "";
  File? file;
  ImagePicker imagePicker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  addImage(ImageSource source) async {
    try {
      final XFile? pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        Reference imageFolder = storage.ref().child('images');
        Reference uploadImage = imageFolder.child("$imageName.jpg");
        await uploadImage.putFile(imageFile);
        downloadUrl = await uploadImage.getDownloadURL();
        notifyListeners();
      }
    } catch (error) {
      print('Error: $error');
      return Exception('Image cannot be added: $error');
    }
    notifyListeners();
  }

  getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      log("image picked");
      notifyListeners();
    }
  }
}
