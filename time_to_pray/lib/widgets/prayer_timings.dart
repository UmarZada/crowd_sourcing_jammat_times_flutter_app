import 'package:flutter/material.dart';

class PrayerTimingsWidget extends StatefulWidget {
  String? name;
  String? time;
  PrayerTimingsWidget({super.key, this.name, this.time});

  @override
  State<PrayerTimingsWidget> createState() => _PrayerTimingsWidgetState();
}

class _PrayerTimingsWidgetState extends State<PrayerTimingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.name.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        trailing: Text(
          widget.time.toString(),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
