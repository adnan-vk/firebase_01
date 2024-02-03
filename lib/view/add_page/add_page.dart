// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/controller/add_edit_provider.dart';
import 'package:practice/model/model.dart';
import 'package:practice/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  late ImagePicker _imagePicker; 
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    

    _imagePicker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: text(data: "ADD DETAILS"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     pickimage();
              //   },
              //   child:
              //       circeavatar(
              //         image: pickedImage!=null ? FileImage(pickedImage!) :
              //         AssetImage('assets/images/Blood Logo.jpg'),
              //         radius: 50.0 
              //         // Icon(Icons.add_a_photo), radius: 50.0
              //         ),
              // ),
              sizedbox(height: 20.0),
              textformfield(
                  controller: namecontroller, label: "Enter your Name"),
              const SizedBox(
                height: 20,
              ),
              textformfield(
                  controller: phonecontroller,
                  label: "Enter The Phone Number",
                  texttype: TextInputType.number,
                  max: 10,
                  data: "+91 "),
              sizedbox(height: 20.0),
              textformfield(
                controller: agecontroller,
                label: "Enter The Your age",
                texttype: TextInputType.number,
                max: 2,
              ),
              sizedbox(height: 20.0),
              DropdownButtonFormField(
                value: Provider.of<AddEditProvider>(context).selectedgroup,
                items:
                    Provider.of<AddEditProvider>(context).listItems.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: text(data: item),
                  );
                }).toList(),
                onChanged: (value) {
                  Provider.of<AddEditProvider>(context, listen: false)
                      .selectedgroup = value.toString();
                },
              ),
              sizedbox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  addData(context);
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    minimumSize:
                        MaterialStatePropertyAll(Size(double.infinity, 50))),
                child: text(data: "SUBMIT", size: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addData(context) {
    final pro = Provider.of<AddEditProvider>(context, listen: false);

    final name = namecontroller.text.trim();
    final phone = int.tryParse(phonecontroller.text.trim());
    final age = int.tryParse(agecontroller.text.trim());

    if (phone == null) {
      log("Invalid phone number input: $phone");
      return;
    }
    final data = BloodModel(
        name: name, phone: phone, group: pro.selectedgroup, age: age);
    pro.addDonor(data);
  }

  void pickimage()async{
    final pickFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if(pickFile!=null){
      pickedImage = File(pickFile.path);
      log("image picked");
    }else{
      log("image not picked");
    }
  }
}