import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_to_pray/global/global.dart';
import 'package:time_to_pray/model/prayer_timings.dart';

import '../registeredMosques/registered_mosques.dart';

class RegisteredYourMosque extends StatefulWidget {
  String? mosqueName;
  String? mainAddress;
  double? latitued;
  double? longtiude;
  RegisteredYourMosque(
      {this.mosqueName,
      this.latitued,
      this.longtiude,
      this.mainAddress,
      super.key});

  @override
  State<RegisteredYourMosque> createState() => _RegisteredYourMosqueState();
}

class _RegisteredYourMosqueState extends State<RegisteredYourMosque> {
  TextEditingController _fajarControlller = TextEditingController();
  TextEditingController _dhuhrControlller = TextEditingController();
  TextEditingController _asrControlller = TextEditingController();
  TextEditingController _maghribControlller = TextEditingController();
  TextEditingController _ishaControlller = TextEditingController();
  TextEditingController _jummaControlller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _testing = false;

  addData() async {
    String id = widget.latitued.toString() + widget.longtiude.toString();
    try {
      setState(() {
        _testing = true;
      });
      var data = PrayerTimings(
        fajar: _fajarControlller.text.trim(),
        dhuhr: _dhuhrControlller.text.trim(),
        asr: _asrControlller.text.trim(),
        maghrib: _maghribControlller.text.trim(),
        isha: _maghribControlller.text.trim(),
        jummaMubark: _jummaControlller.text.trim(),
        mosqueId: id,
        mosqueName: widget.mosqueName,
        latlng: (widget.latitued.toString()) + (widget.longtiude.toString()),
        address: widget.mainAddress,
        timingStatus: "normal",
        userId: firebaseAuth.currentUser!.uid,
        personEmail: firebaseAuth.currentUser!.email,
      ).toJson();
      await firestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("mosquesAdd")
          .doc(id)
          .set(data)
          .then((value) {
        firestore.collection("mosques").doc(id).set(data);
      });

      setState(() {
        _testing = false;
      });
      Fluttertoast.showToast(msg: "Data Added Successfully");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RegisteredMosques()));
    } on FirebaseException catch (e) {
      setState(() {
        _testing = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register Mosque"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                    height: 40.0,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.black,
                        )),
                    child: Text(
                      widget.mosqueName.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 35.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          textFieldRow("Fajar", "fajar", _fajarControlller),
                          textFieldRow("Dhuhr", "Dhuhr", _dhuhrControlller),
                          textFieldRow("Asr", "Asr", _asrControlller),
                          textFieldRow(
                              "Maghrib", "Maghrib", _maghribControlller),
                          textFieldRow("Isha", "Isha", _ishaControlller),
                          const SizedBox(
                            height: 10.0,
                          ),
                          textFieldRow("Jumma Mubark", "Jumma Mubark",
                              _jummaControlller),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "Please give correct Timings, and update with time to Time when pragyer time changes"),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      addData();
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width - 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.blueGrey,
                    ),
                    child: Center(
                      child: _testing == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldRow(
      String title, String hintText, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title : ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              width: 200.0,
              height: (_formKey.currentState != null &&
                      _formKey.currentState == true)
                  ? 45
                  : 60,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
