import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_to_pray/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time to Pray App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      //home: MyLoginScreen(),
      home: const Splash(), // we comment this to return as splash screen
    );
  }
}
