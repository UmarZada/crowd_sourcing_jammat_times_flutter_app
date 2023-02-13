import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_to_pray/global/global.dart';
import 'package:time_to_pray/model/prayer_timings.dart';

class MosqueDetails extends StatefulWidget {
  final PrayerTimings? data;
  MosqueDetails({super.key, this.data});

  @override
  State<MosqueDetails> createState() => _MosqueDetailsState();
}

class _MosqueDetailsState extends State<MosqueDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data!.mosqueName.toString()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: SizedBox(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sent By : ",
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        Text(
                          widget.data!.personEmail.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Fajar : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                        Text(
                          widget.data!.fajar.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Dhuhr : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                        Text(
                          widget.data!.dhuhr.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Asr : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                        Text(
                          widget.data!.asr.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Maghrib : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                        Text(
                          widget.data!.maghrib.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Isha : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                        Text(
                          widget.data!.isha.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "JummaMubark : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20.0),
                            ),
                            Text(
                              widget.data!.jummaMubark.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    widget.data!.timingStatus == "normal"
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Alert!"),
                                            content: const Text(
                                                "Do you Want to Cancel Request?"),
                                            actions: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0, right: 20.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        cancelRequest(
                                                          widget.data!.latlng
                                                              .toString(),
                                                          widget.data!.userId
                                                              .toString(),
                                                        );
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Request has been Removed!");
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
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      approvedRequest(
                                          widget.data!.latlng.toString(),
                                          widget.data!.userId.toString());
                                      Navigator.of(context).pop();
                                      Fluttertoast.showToast(msg: "Approved!");
                                    },
                                    child: const Text("Approved"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  cancelRequest(String reqid, String userId) async {
    await firestore.collection("mosques").doc(reqid).delete();
    await firestore
        .collection("users")
        .doc(userId)
        .collection("mosquesAdd")
        .doc(reqid)
        .delete();
  }

  approvedRequest(String reqid, String userId) async {
    await firestore
        .collection("mosques")
        .doc(reqid)
        .update({"timingStatus": "approved"});
    await firestore
        .collection("users")
        .doc(userId)
        .collection("mosquesAdd")
        .doc(reqid)
        .update({
      "timingStatus": "approved",
    });
  }
}
