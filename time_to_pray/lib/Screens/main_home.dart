import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_to_pray/Screens/azkar/main_azkar.dart';
import 'package:time_to_pray/Screens/home/home_screen.dart';
import 'package:time_to_pray/Screens/qibla/qibla.dart';
import 'package:time_to_pray/Screens/settings/main_settings.dart';

import '../utils/fetch_timings.dart';
import '../utils/location.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final _pageController = PageController();

  var currentMonth;
  var currentYear;
  var index;
  String completeAdd = "";
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

  getDAta() async {
    currentMonth = DateFormat.M().format(DateTime.now());
    currentYear = DateFormat.y().format(DateTime.now());
    index = DateFormat.d().format(DateTime.now());
    await getCurrentLocation();
    await getTimings(currentMonth, currentYear, int.parse(index));
    print(completeAddress);
    completeAdd = completeAddress;
    fajr = fajr1.substring(0, fajr1.length - 5);
    sunrise = sunrise1.substring(0, fajr1.length - 5);
    dhuhr = dhuhr1.substring(0, fajr1.length - 5);
    asr = asr1.substring(0, fajr1.length - 5);
    sunset = sunrise1.substring(0, fajr1.length - 5);
    maghrib = maghrib1.substring(0, fajr1.length - 5);
    isha = isha1.substring(0, fajr1.length - 5);
    imsak = imsak1.substring(0, fajr1.length - 5);
    midnight = midnight1.substring(0, fajr1.length - 5);
    firstthird = firstthird1.substring(0, fajr1.length - 5);
    lastthird = lastthird1.substring(0, fajr1.length - 5);
    setState(() {});
  }

  @override
  void initState() {
    getDAta();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // copied from bottom bar pub.dev
        body: PageView(
          controller: _pageController,
          children: [
            //continaner a for page 01 Home
            HomeScreen(
              currentMonth: currentMonth,
              completeAdd: completeAddress,
              currentYear: currentYear,
              fajr: fajr,
              dhuhr: dhuhr,
              asr: asr,
              maghrib: maghrib,
              isha: isha,
              imsak: imsak,
              firstthird: firstthird,
              index: index,
              lastthird: lastthird,
              midnight: midnight,
              sunrise: sunrise,
              sunset: sunset,
            ),
            // Container b for page 02 Qibla
            const MianQiblaScrren(),

            //Contianer c for page 03 Azkar
            const MainAzkarScreen(),

            //container d for page 04 settings
            MainSettingScreen(),
          ],
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
        ),
        bottomNavigationBar: BottomBar(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedIndex: _currentPage,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.yellow,
              activeTitleColor: Colors.blue.shade600,
            ),
            BottomBarItem(
              icon: const Icon(Icons.mosque_outlined),
              title: const Text('Qibla'),
              activeColor: Colors.yellow,
              activeTitleColor: Colors.blue.shade600,
            ),
            BottomBarItem(
              icon: const Icon(Icons.add),
              title: const Text('Azkar'),
              backgroundColorOpacity: 0.1,
              activeColor: Colors.yellow,
              activeTitleColor: Colors.blue.shade600,
            ),
            BottomBarItem(
              icon: const Icon(Icons.calendar_month_rounded),
              title: const Text('Calender'),
              activeColor: Colors.yellow,
              activeTitleColor: Colors.blue.shade600,
              //activeTitleColor: Colors.orange.shade700,
            ),
          ],
        ),

        //copied from bottom bar pub.dev
      ),
    );
  }
}
