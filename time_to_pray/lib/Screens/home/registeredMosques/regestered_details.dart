import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/home/registeredMosques/edit_timings.dart';
import 'package:time_to_pray/model/prayer_timings.dart';

class RegisteredDetails extends StatefulWidget {
  final PrayerTimings? data;
  const RegisteredDetails({super.key, this.data});

  @override
  State<RegisteredDetails> createState() => _RegisteredDetailsState();
}

class _RegisteredDetailsState extends State<RegisteredDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Details Timings"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: SizedBox(
              height: 335,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Your Request Status : ",
                          style: TextStyle(color: Colors.blue, fontSize: 18.0),
                        ),
                        Text(
                          widget.data!.timingStatus == "normal"
                              ? "Pending"
                              : "Approved",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: widget.data!.timingStatus == "normal"
                                  ? Colors.red
                                  : Colors.green,
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditTimings(
                                    data: widget.data,
                                  )));
                        },
                        child: const Text("Edit"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
