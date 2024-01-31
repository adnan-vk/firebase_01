// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/controller/add_edit_provider.dart';
import 'package:practice/model/model.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: namecontroller,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: phonecontroller,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: Provider.of<AddEditProvider>(context).selectedgroup,
              items:
                  Provider.of<AddEditProvider>(context).listItems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                Provider.of<AddEditProvider>(context, listen: false)
                    .selectedgroup = value.toString();
              },
            ),
            ElevatedButton(
              onPressed: () {
                addData(context);
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50))),
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }

  addData(context) {
    final pro = Provider.of<AddEditProvider>(context, listen: false);

    final name = namecontroller.text;
    final phoneText =
        phonecontroller.text.trim(); // Remove leading and trailing whitespaces
    final phone = int.tryParse(phoneText);

    if (phone == null) {
      print("Invalid phone number input: $phoneText");
      // You may want to show an error message to the user.
      return;
    }

    print("Name: $name");
    print("Phone: $phone");
    print(pro.selectedgroup);

    final data = BloodModel(name: name, phone: phone, group: pro.selectedgroup);
    pro.AddDonor(data);
  }
}
