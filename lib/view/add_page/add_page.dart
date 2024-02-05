// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/controller/add_edit_provider.dart';
import 'package:practice/controller/image_provider.dart';
import 'package:practice/model/model.dart';
import 'package:practice/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ImgProvider>(context, listen: false);
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
              Consumer<ImgProvider>(
                builder: (context, value, child) => GestureDetector(
                  onTap: () {
                    pro.pickImage(context);
                  },
                  child: circeavatar(
                    image: value.pickedImage != null
                        ? FileImage(value.pickedImage!)
                        : null,
                    radius: 50.0,
                    color: Colors.red,
                    child: Icon(Icons.add_a_photo),
                  ),
                ),
              ),
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

    if (phone == null || name.isEmpty || age == null) {
      log("Invalid Input");
      return;
    }
    final data = BloodModel(
        name: name, phone: phone, group: pro.selectedgroup, age: age);
    pro.addDonor(data);
  }
}
