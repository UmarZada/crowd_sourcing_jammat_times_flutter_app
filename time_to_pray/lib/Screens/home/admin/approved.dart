import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/home/admin/mosque_details.dart';

import '../../../global/global.dart';
import '../../../model/prayer_timings.dart';

class ApprovedRequests extends StatefulWidget {
  const ApprovedRequests({super.key});

  @override
  State<ApprovedRequests> createState() => _ApprovedRequestsState();
}

class _ApprovedRequestsState extends State<ApprovedRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height - 30.0,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: firestore
            .collection("mosques")
            .where("timingStatus", isEqualTo: "approved")
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

          return snapshot.data!.docs.isEmpty
              ? Container(
                  child: Center(
                    child: Text("No yet Accepted!"),
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = PrayerTimings.fromJson(
                        (snapshot.data! as dynamic).docs[index].data());

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MosqueDetails(
                                  data: data,
                                )));
                      },
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Text("T"),
                        ),
                        title: Text(data.mosqueName.toString()),
                        subtitle: Text(data.userId.toString()),
                      ),
                    );
                  },
                );
        },
      ),
    ));
  }
}
