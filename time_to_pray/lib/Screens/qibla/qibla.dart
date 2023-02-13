import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:time_to_pray/Screens/qibla/qibla_compss.dart';
import 'package:time_to_pray/Screens/qibla/qibla_maps.dart';

class MianQiblaScrren extends StatefulWidget {
  const MianQiblaScrren({super.key});

  @override
  State<MianQiblaScrren> createState() => _MianQiblaScrrenState();
}

class _MianQiblaScrrenState extends State<MianQiblaScrren> {
  @override
  Widget build(BuildContext context) {
    final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qibla Direction"),
        actions: [const Icon(Icons.location_on)],
      ),
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.hasError)
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );

          if (snapshot.data!) {
            return QiblahCompass();
          } else {
            return QiblahMaps();
          }
        },
      ),
    );
  }
}
