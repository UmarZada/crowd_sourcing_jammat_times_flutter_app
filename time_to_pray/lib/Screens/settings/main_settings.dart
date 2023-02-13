import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';

class MainSettingScreen extends StatefulWidget {
  MainSettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainSettingScreenState createState() => new _MainSettingScreenState();
}

class _MainSettingScreenState extends State<MainSettingScreen> {
  var selectedDate = new HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal(Localizations.localeOf(context).languageCode);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calender"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Text(
                '${selectedDate.toString()}',
                style: Theme.of(context).textTheme.headline5,
              ),
              new Text(
                '${selectedDate.fullDate()}',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 10.0,
              ),
              HijriMonthPicker(
                lastDate: HijriCalendar()
                  ..hYear = 1445
                  ..hMonth = 9
                  ..hDay = 25,
                firstDate: HijriCalendar()
                  ..hYear = 1438
                  ..hMonth = 12
                  ..hDay = 25,
                onChanged: (HijriCalendar value) {
                  setState(() {
                    selectedDate = selectedDate;
                  });
                },
                selectedDate: selectedDate,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final HijriCalendar? picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate: new HijriCalendar()
        ..hYear = 1445
        ..hMonth = 9
        ..hDay = 25,
      firstDate: new HijriCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }
}
