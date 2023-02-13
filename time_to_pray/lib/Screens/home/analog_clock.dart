import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';

class AnalogClockScreen extends StatefulWidget {
  const AnalogClockScreen({super.key});

  @override
  State<AnalogClockScreen> createState() => _AnalogClockScreenState();
}

class _AnalogClockScreenState extends State<AnalogClockScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnalogClock(
          decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.black),
              color: Colors.transparent,
              shape: BoxShape.circle),
          width: 100.0,
          isLive: true,
          hourHandColor: Colors.black,
          minuteHandColor: Colors.black,
          showSecondHand: true,
          numberColor: Colors.black87,
          showNumbers: true,
          showAllNumbers: false,
          textScaleFactor: 1.4,
          showTicks: true,
          showDigitalClock: true,
          datetime: DateTime.now()),
    );
  }
}
