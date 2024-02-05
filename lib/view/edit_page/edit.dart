// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/controller/add_edit_provider.dart';
import 'package:practice/controller/image_provider.dart';
import 'package:practice/model/model.dart';
import 'package:practice/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  BloodModel donor;
  String id;
  EditPage({super.key, required this.donor, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController(text: widget.donor.name);
    phonecontroller =
        TextEditingController(text: widget.donor.phone.toString());
    agecontroller = TextEditingController(text: widget.donor.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<AddEditProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: text(data: "EDIT PAGE"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Consumer<ImgProvider>(
                builder: (context, value, child) => GestureDetector(
                  onTap: () {
                    // pickImage(context);b
                  },
                  child: circeavatar(
                    // image: value.pickedImage != null
                    //     ? FileImage(value.pickedImage!)
                    //     : null,
                    radius: 50.0,
                    color: Colors.red,
                    child: Icon(Icons.add_a_photo),
                  ),
                ),
              ),
              textformfield(controller: namecontroller),
              SizedBox(
                height: 20,
              ),
              textformfield(
                  controller: phonecontroller,
                  texttype: TextInputType.number,
                  max: 10),
              SizedBox(
                height: 20,
              ),
              textformfield(
                  controller: agecontroller,
                  texttype: TextInputType.number,
                  max: 2),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: pro.selectedgroup,
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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  update();
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    minimumSize:
                        MaterialStatePropertyAll(Size(double.infinity, 50))),
                child: text(data: "UPDATE", size: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void update() {
    final pro = Provider.of<AddEditProvider>(context, listen: false);
    final name = namecontroller.text.trim();
    final phone = int.parse(phonecontroller.text.trim());
    final age = int.tryParse(agecontroller.text.trim());

    final updated = BloodModel(
        name: name, phone: phone, group: pro.selectedgroup, age: age);
    pro.updatedonor(updated, widget.id);
    Navigator.pop(context);
  }
}
