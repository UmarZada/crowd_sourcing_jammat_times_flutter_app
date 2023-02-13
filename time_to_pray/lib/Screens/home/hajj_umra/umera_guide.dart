import 'package:flutter/material.dart';

class UmraGuideScreen extends StatefulWidget {
  const UmraGuideScreen({super.key});

  @override
  State<UmraGuideScreen> createState() => _UmraGuideScreenState();
}

class _UmraGuideScreenState extends State<UmraGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Umra Guide"),
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
