import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/main_home.dart';
import 'package:time_to_pray/Screens/authentication/login/login_screen.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1000,
      backgroundColor: Colors.blueGrey,
      splash: ('assets/images/m12.png'),
      nextScreen: const wrapper(),
      splashTransition: SplashTransition.sizeTransition,
    );
  }
}

class wrapper extends StatefulWidget {
  const wrapper({super.key});

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  authentication() {
    Timer(const Duration(milliseconds: 0), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyLoginScreen()));
      }
    });
  }

  @override
  void initState() {
    authentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
