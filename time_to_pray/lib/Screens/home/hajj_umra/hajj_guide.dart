import 'package:flutter/material.dart';

class HajjGuideScreen extends StatefulWidget {
  const HajjGuideScreen({super.key});

  @override
  State<HajjGuideScreen> createState() => _HajjGuideScreenState();
}

class _HajjGuideScreenState extends State<HajjGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hajj Guide"),
      ),
    );
  }
}
