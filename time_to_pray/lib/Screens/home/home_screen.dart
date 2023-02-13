import 'package:analog_clock/analog_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:time_to_pray/Screens/home/registeredMosques/registered_mosques.dart';
import 'package:time_to_pray/Screens/home/nearest%20Masjid/main_nearest_masjid.dart';
import 'package:time_to_pray/Screens/home/quran/main_quran_screen.dart';
import 'package:time_to_pray/components/database.dart';
import 'package:time_to_pray/global/global.dart';
import 'package:time_to_pray/widgets/circular_design.dart';
import 'package:time_to_pray/widgets/my_drawer.dart';
import 'package:time_to_pray/widgets/prayer_timings.dart';

import '../../model/user_model.dart';
import 'admin/admin.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var currentMonth;
  // ignore: prefer_typing_uninitialized_variables
  var currentYear;
  // ignore: prefer_typing_uninitialized_variables
  var index;
  String? completeAdd;
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;
  HomeScreen({
    super.key,
    this.currentMonth,
    this.currentYear,
    this.index,
    this.completeAdd,
    this.fajr,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
    this.sunrise,
    this.sunset,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: firebaseAuth.currentUser == null
            ? null
            : AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.horizontal_split_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Alert!"),
                              content: const Text("Do you Want to logOut?"),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          Database().logout(context);
                                          Fluttertoast.showToast(
                                              msg: "You are logout");
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
                      icon: const Icon(
                        Icons.logout,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/m1.jpeg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .35,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black45.withOpacity(0.7),
                    ),
                  ),
                  Positioned(
                    top: 50.0,
                    left: 15.0,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 160,
                              width: 170,
                              child: AnalogClock(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3.5, color: Colors.white),
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                width: 130.0,
                                isLive: true,
                                hourHandColor: Colors.white,
                                minuteHandColor: Colors.white,
                                showSecondHand: true,
                                numberColor: Colors.white,
                                showNumbers: true,
                                showAllNumbers: false,
                                textScaleFactor: 1.7,
                                showTicks: true,
                                showDigitalClock: true,
                                digitalClockColor: Colors.white,
                                datetime: DateTime.now(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.wb_sunny_rounded,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 3.0,
                                ),
                                Text(
                                  "${widget.sunrise} am",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_sharp,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 3.0,
                                  ),
                                  Text(
                                    DateFormat.yMMMEd()
                                        .format(DateTime.now())
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 3.0,
                                ),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          10,
                                  child: Text(
                                    widget.completeAdd.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 40.0,
                padding: const EdgeInsets.only(top: 10.0),
                child: const Center(
                    child: Text(
                  "Times to Pray",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                )),
              ),
              // ignore: avoid_unnecessary_containers
              widget.lastthird == null
                  ? Container(
                      height: 460,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox(
                      height: 460,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          PrayerTimingsWidget(
                            name: "Fajar",
                            time: "${widget.fajr} am",
                          ),
                          PrayerTimingsWidget(
                            name: "Sunrise",
                            time: "${widget.sunrise} am",
                          ),
                          PrayerTimingsWidget(
                            name: "Dhuhr",
                            time: "${widget.dhuhr} am",
                          ),
                          PrayerTimingsWidget(
                            name: "Asr",
                            time: "${widget.asr} pm",
                          ),
                          PrayerTimingsWidget(
                            name: "Sunset",
                            time: "${widget.sunset} pm ",
                          ),
                          PrayerTimingsWidget(
                            name: "Maghrib",
                            time: "${widget.maghrib} pm",
                          ),
                          PrayerTimingsWidget(
                            name: "Isha",
                            time: "${widget.isha} pm",
                          ),
                        ],
                      ),
                    ),
              Container(
                height: 120.0,
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const SizedBox(
                        //   width: 5.0,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //     top: 4.0,
                        //     left: 5.0,
                        //     right: 5.0,
                        //     bottom: 5.0,
                        //   ),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) =>
                        //               const MainGuideScreen()));
                        //     },
                        //     child: CircularDesignWidget(
                        //       imagePath: "assets/images/splash.png",
                        //       imageName: "Hajj-Umera",
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 5.0,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4.0,
                            left: 5.0,
                            right: 5.0,
                            bottom: 5.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const NearestMasjid()));
                            },
                            child: CircularDesignWidget(
                              imagePath: "assets/images/m4.jpeg",
                              imageName: "Nearest \n Masjid",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4.0,
                            left: 5.0,
                            right: 5.0,
                            bottom: 5.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const MainQuranScreen()));
                            },
                            child: CircularDesignWidget(
                              imagePath: "assets/images/m6.jpeg",
                              imageName: "Quran",
                            ),
                          ),
                        ),
                        firebaseAuth.currentUser == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                  left: 5.0,
                                  right: 5.0,
                                  bottom: 5.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisteredMosques()));
                                  },
                                  child: CircularDesignWidget(
                                    imagePath: "assets/images/m7.jpeg",
                                    imageName: "Registed\nMosques",
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
