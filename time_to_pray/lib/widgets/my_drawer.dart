import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_to_pray/Screens/azkar/main_azkar.dart';
import 'package:time_to_pray/Screens/home/registeredMosques/registered_mosques.dart';

import '../Screens/home/admin/admin.dart';
import '../Screens/home/nearest Masjid/main_nearest_masjid.dart';
import '../global/global.dart';
import '../model/user_model.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Container(
              color: Colors.blueGrey,
              child: const Center(
                child: CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.white,
                  child: Text("M"),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NearestMasjid()));
              },
              child: list("Nearest Masjid", Icons.mosque_outlined)),
          const Divider(),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MainAzkarScreen()));
              },
              child: list("Counter", Icons.add)),
          const Divider(),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisteredMosques()));
              },
              child:
                  list("Registered Masjids", Icons.app_registration_outlined)),
          const Divider(),
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Alert!"),
                      content: const Text("Do you Want to logOut?"),
                      actions: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  // await logOut(context);
                                  Fluttertoast.showToast(msg: "You are logout");
                                },
                                child: const Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: list("logout", Icons.logout)),
          const Divider(),
          Container(
            height: 100.0,
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("users")
                  .where("status", isEqualTo: "admin")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: const Center(
                      child: Text("Loading......"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = UserModel.fromJson(
                        (snapshot.data! as dynamic).docs[index].data());

                    return data.userId == firebaseAuth.currentUser!.uid
                        ? InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminControlScreen()));
                            },
                            child: list("Admin", Icons.person_outline_rounded))
                        : Container();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget list(String title, IconData icon) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
  );
}
