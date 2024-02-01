import 'package:flutter/material.dart';
import 'package:practice/controller/add_edit_provider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller = TextEditingController(text: widget.donor.name);
    phonecontroller =
        TextEditingController(text: widget.donor.phone.toString());
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<AddEditProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            textformfield(controller: namecontroller),
            const SizedBox(
              height: 20,
            ),
            textformfield(
                controller: phonecontroller, texttype: TextInputType.number),
            const SizedBox(
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
            ElevatedButton(
              onPressed: () {
                update();
              },
              style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50))),
              child: const Text("UPDATE"),
            ),
          ],
        ),
      ),
    );
  }

  void update() {
    final pro = Provider.of<AddEditProvider>(context, listen: false);
    final name = namecontroller.text;
    final phone = int.parse(phonecontroller.text.trim());

    final updated =
        BloodModel(name: name, phone: phone, group: pro.selectedgroup);
    pro.updatedonor(widget.id, updated);
    Navigator.pop(context);
  }
}
