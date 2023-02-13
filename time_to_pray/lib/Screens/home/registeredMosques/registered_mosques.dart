import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/home/registeredMosques/regestered_details.dart';
import 'package:time_to_pray/global/global.dart';
import 'package:time_to_pray/model/prayer_timings.dart';

class RegisteredMosques extends StatefulWidget {
  const RegisteredMosques({super.key});



  @override
  State<RegisteredMosques> createState() => _RegisteredMosquesState();
}

class _RegisteredMosquesState extends State<RegisteredMosques> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BookMarked Mosques"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore
                  .collection("users")
                  .doc(firebaseAuth.currentUser!.uid)
                  .collection("mosquesAdd")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Loading ......"));
                }
                return snapshot.data!.docs.isEmpty
                    // ignore: avoid_unnecessary_containers
                    ? Container(
                        child: const Center(
                          child: Text(
                            "No Mosque are Regesterd by You!",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          PrayerTimings data = PrayerTimings.fromJson(
                              snapshot.data!.docs[index].data());
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisteredDetails(
                                        data: data,
                                      )));
                            },
                            child: wigetMosque(data.mosqueName.toString(),
                                data.address.toString()),
                          );
                        },
                      );
              }),
        ),
      ),
    );
  }

  Widget wigetMosque(String name, String address) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(address),
      ),
    );
  }
}
