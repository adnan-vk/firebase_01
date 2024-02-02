// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/controller/add_edit_provider.dart';
import 'package:practice/controller/home_provider.dart';
import 'package:practice/model/model.dart';
import 'package:practice/view/add_page/add_page.dart';
import 'package:practice/view/edit_page/edit.dart';
import 'package:practice/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<AddEditProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Donor List'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) => StreamBuilder(
          stream: value.getdatas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: text(data: "Error: ${snapshot.error}"),
              );
            }
            List<QueryDocumentSnapshot<BloodModel>> donordetail =
                snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: donordetail.length,
              itemBuilder: (context, index) {
                BloodModel donor = donordetail[index].data();
                final id = donordetail[index].id;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                        leading: circeavatar(
                          color: Colors.red,
                          child: text(data: donor.group, size: 20.0),
                          radius: 30.0,
                        ),
                        title: text(data: donor.name, size: 16.0),
                        subtitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              sizedbox(height: 10.0),
                              text(data: donor.phone.toString(), size: 14.0),
                              sizedbox(height: 10.0),
                              text(data: "Age : ${donor.age.toString()}")
                            ],
                          ),
                        ),
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'edit') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditPage(donor: donor, id: id),
                                  ));
                            } else if (value == "delete") {
                              pro.delete(id);
                            }
                            ;
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: text(data: "edit"),
                                value: "edit",
                              ),
                              PopupMenuItem(
                                child: text(data: "DELETE"),
                                value: "delete",
                              ),
                            ];
                          },
                        )),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
