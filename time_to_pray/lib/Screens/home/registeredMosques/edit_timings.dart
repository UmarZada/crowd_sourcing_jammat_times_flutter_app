import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_to_pray/global/global.dart';
import 'package:time_to_pray/model/prayer_timings.dart';
import 'package:time_to_pray/utils/fetch_timings.dart';

import '../registeredMosques/registered_mosques.dart';

class EditTimings extends StatefulWidget {
  PrayerTimings? data;
  EditTimings({super.key, this.data});

  @override
  State<EditTimings> createState() => _EditTimingsState();
}

class _EditTimingsState extends State<EditTimings> {
  TextEditingController _fajarControlller = TextEditingController();
  TextEditingController _dhuhrControlller = TextEditingController();
  TextEditingController _asrControlller = TextEditingController();
  TextEditingController _maghribControlller = TextEditingController();
  TextEditingController _ishaControlller = TextEditingController();
  TextEditingController _jummaControlller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _testing = false;

  editData() async {
    String id = widget.data!.mosqueId.toString();
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
        mosqueName: widget.data!.mosqueName.toString(),
        latlng: id,
        address: widget.data!.address.toString(),
        timingStatus: "normal",
        userId: widget.data!.userId,
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
  void initState() {
    _fajarControlller.text = widget.data!.fajar.toString();
    _dhuhrControlller.text = widget.data!.dhuhr.toString();
    _asrControlller.text = widget.data!.asr.toString();
    _maghribControlller.text = widget.data!.maghrib.toString();
    _maghribControlller.text = widget.data!.isha.toString();
    _ishaControlller.text = widget.data!.isha.toString();
    _jummaControlller.text = widget.data!.jummaMubark.toString();
    super.initState();
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
                      widget.data!.mosqueName.toString(),
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
                      editData();
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
                              "Save",
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
    return SizedBox(
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
