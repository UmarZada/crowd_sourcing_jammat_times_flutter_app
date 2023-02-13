import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:time_to_pray/Screens/home/registeredMosques/edit_timings.dart';
import 'package:time_to_pray/Screens/home/registeredMosques/registered_mosques.dart';
import 'package:time_to_pray/Screens/home/nearest%20Masjid/register_mosque.dart';
import 'package:time_to_pray/global/global.dart';
import 'package:time_to_pray/model/prayer_timings.dart';
import 'package:time_to_pray/utils/location.dart';

class NearestMasjid extends StatefulWidget {
  const NearestMasjid({super.key});

  @override
  State<NearestMasjid> createState() => _NearestMasjidState();
}

class _NearestMasjidState extends State<NearestMasjid> {
  String radius = "100";
  String apiKey = "";
  Completer<GoogleMapController> _completer = Completer();
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(double.parse(lat), double.parse(lng)),
    zoom: 14,
  );

  CustomInfoWindowController _customInfoController =
      CustomInfoWindowController();
  List<Marker> _marker = [];
  final List<Marker> _list = [
    // Marker(
    //     markerId: MarkerId("1"),
    //     position: LatLng(34.025917, 71.560135),
    //     infoWindow: InfoWindow(
    //       title: "My current location",
    //     )),
    // Marker(
    //     markerId: MarkerId("2"),
    //     position: LatLng(33.9749573, 71.4728359),
    //     infoWindow: InfoWindow(
    //       title: "Ring Road",
    //     )),
  ];

  getNearbyPlaces() async {
    var url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=masjid&location=$lat,$lng&radius=700&type=masjid&key=AIzaSyBkFKe9G3OALJOy4TISPDw-TGd2ondqE4U";

    var response = await http.post(Uri.parse(url));
    var json = await jsonDecode(response.body.toString());

    for (var i in json["results"]) {
      _list.add(
        Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(i["geometry"]["location"]["lat"],
                i["geometry"]["location"]["lng"]),
            onTap: () {
              _customInfoController.addInfoWindow!(
                Container(
                  height: 300.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white70.withOpacity(0.9),
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: 50.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            color: Colors.blueGrey,
                          ),
                          child: Center(
                            child: Text(
                              i["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: const Center(
                          child: Text(
                            "Prayers Timings",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection("mosques")
                                .where("mosqueId",
                                    isEqualTo: i["geometry"]["location"]["lat"]
                                            .toString() +
                                        i["geometry"]["location"]["lng"]
                                            .toString())
                                .where("timingStatus", isEqualTo: "approved")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                    height: 120,
                                    child: Center(child: Text("Loading.....")));
                              }

                              return snapshot.data!.docs.length > 0
                                  ? snapshot.data!.docs[0]["mosqueId"] ==
                                          i["geometry"]["location"]["lat"]
                                                  .toString() +
                                              i["geometry"]["location"]["lng"]
                                                  .toString()
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Fajar : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[0]
                                                        ["fajar"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Dhuhr : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[0]
                                                        ["dhuhr"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Asr : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[0]
                                                        ["asr"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Maghrib : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[0]
                                                        ["maghrib"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Isha : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[0]
                                                        ["isha"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Container(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      const Text(
                                                        "JummaMubark : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 15.0),
                                                      ),
                                                      Text(
                                                        snapshot.data!.docs[0]
                                                            ["jummaMubark"],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.blue,
                                                            fontSize: 17.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              snapshot.data!.docs[0]
                                                          ["userId"] ==
                                                      firebaseAuth
                                                          .currentUser!.uid
                                                  ? ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditTimings(
                                                                          data:
                                                                              PrayerTimings(
                                                                            fajar:
                                                                                snapshot.data!.docs[0]["fajar"],
                                                                            dhuhr:
                                                                                snapshot.data!.docs[0]["dhuhr"],
                                                                            asr:
                                                                                snapshot.data!.docs[0]["asr"],
                                                                            maghrib:
                                                                                snapshot.data!.docs[0]["maghrib"],
                                                                            isha:
                                                                                snapshot.data!.docs[0]["isha"],
                                                                            address:
                                                                                snapshot.data!.docs[0]["address"],
                                                                            jummaMubark:
                                                                                snapshot.data!.docs[0]["jummaMubark"],
                                                                            latlng:
                                                                                snapshot.data!.docs[0]["latlng"],
                                                                            mosqueId:
                                                                                snapshot.data!.docs[0]["mosqueId"],
                                                                            mosqueName:
                                                                                snapshot.data!.docs[0]["mosqueName"],
                                                                            timingStatus:
                                                                                snapshot.data!.docs[0]["timingStatus"],
                                                                            userId:
                                                                                snapshot.data!.docs[0]["userId"],
                                                                          ),
                                                                        )));
                                                      },
                                                      child: const Text("Edit"),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          height: 120,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                  "Mosque not registerd"),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              firebaseAuth.currentUser == null
                                                  ? Container()
                                                  : ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RegisteredYourMosque(
                                                                          mosqueName:
                                                                              i["name"],
                                                                          latitued:
                                                                              i["geometry"]["location"]["lat"],
                                                                          longtiude:
                                                                              i["geometry"]["location"]["lng"],
                                                                          mainAddress:
                                                                              i["vicinity"],
                                                                        )));
                                                      },
                                                      child: const Text(
                                                          "Register Mosque"),
                                                    )
                                            ],
                                          ),
                                        )
                                  : SizedBox(
                                      height: 120,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Mosque not registerd"),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          firebaseAuth.currentUser == null
                                              ? Container()
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RegisteredYourMosque(
                                                                  mosqueName:
                                                                      i["name"],
                                                                  latitued:
                                                                      i["geometry"]
                                                                              [
                                                                              "location"]
                                                                          [
                                                                          "lat"],
                                                                  longtiude:
                                                                      i["geometry"]
                                                                              [
                                                                              "location"]
                                                                          [
                                                                          "lng"],
                                                                  mainAddress: i[
                                                                      "vicinity"],
                                                                )));
                                                  },
                                                  child: const Text(
                                                      "Register Mosque"),
                                                ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                LatLng(i["geometry"]["location"]["lat"],
                    i["geometry"]["location"]["lng"]),
              );
            }
            // infoWindow: InfoWindow(
            //   title: i["name"],
            // ),
            ),
      );
      // print(i["geometry"]["location"]["lat"]);
      // print(i["name"]);
    }
    _marker.addAll(_list);
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      getNearbyPlaces();
      // Prints after 1 second.
    });

    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_marker),
            onTap: (argument) {
              _customInfoController.hideInfoWindow!();
            },
            onMapCreated: (GoogleMapController controller) {
              _completer.complete(controller);
              _customInfoController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoController,
            height: 260.0,
            width: 230,
            offset: 35,
          )
        ],
      )),
    );
  }
}
