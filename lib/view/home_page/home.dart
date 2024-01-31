// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/controller/home_provider.dart';
import 'package:practice/model/model.dart';
import 'package:practice/view/add_page/add_page.dart';
import 'package:practice/view/edit_page/edit.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                child: Text("error : ${snapshot.error}"),
              );
            }
            List<QueryDocumentSnapshot<BloodModel>> donordetail =
                snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: donordetail.length,
              itemBuilder: (context, index) {
                BloodModel donor = donordetail[index].data();
                final id = donordetail[index].id;
                return Card(
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          donor.group ?? 'na',
                          style: const TextStyle(fontSize: 30),
                        ),
                        radius: 40,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(donor.name!),
                          Text(donor.phone.toString()),
                        ],
                      ),
                      Align(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const EditPage(),
                                      ));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
