import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/home/hajj_umra/hajj_guide.dart';
import 'package:time_to_pray/Screens/home/hajj_umra/umera_guide.dart';

class MainGuideScreen extends StatelessWidget {
  const MainGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guide Line"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HajjGuideScreen()));
                },
                child: Text("Hajj Guide")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UmraGuideScreen()));
                },
                child: Text("Umra Guide")),
          ],
        ),
      ),
    );
  }
}
