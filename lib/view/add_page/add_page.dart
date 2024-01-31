// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practice/controller/add_edit_provider.dart';
import 'package:practice/model/model.dart';
import 'package:practice/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: text(data: "ADD DETAILS"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            textformfield(controller: namecontroller, label: "Enter your Name"),
            const SizedBox(
              height: 20,
            ),
            textformfield(controller: phonecontroller, label: "Enter The Phone Number",texttype: TextInputType.number,),
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
    );
  }

  addData(context) {
    final pro = Provider.of<AddEditProvider>(context, listen: false);

    final name = namecontroller.text;
    final phoneText = phonecontroller.text.trim();
    final phone = int.tryParse(phoneText);

    if (phone == null) {
      log("Invalid phone number input: $phoneText");
      return;
    }

    log("Name: $name");
    log("Phone: $phone");
    log(pro.selectedgroup);

    final data = BloodModel(name: name, phone: phone, group: pro.selectedgroup);
    pro.addDonor(data);
  }
}
