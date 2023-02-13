import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/home/admin/mosque_details.dart';
import 'package:time_to_pray/global/global.dart';

import '../../../model/prayer_timings.dart';

class UpCompingRequest extends StatefulWidget {
  const UpCompingRequest({super.key});

  @override
  State<UpCompingRequest> createState() => _UpCompingRequestState();
}

class _UpCompingRequestState extends State<UpCompingRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height - 30.0,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: firestore
            .collection("mosques")
            .where("timingStatus", isEqualTo: "normal")
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
                                  data: PrayerTimings.fromJson(
                                      (snapshot.data! as dynamic)
                                          .docs[index]
                                          .data()),
                                )));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
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
