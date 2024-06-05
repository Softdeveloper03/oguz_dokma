import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:oguz_dokma/esasy_sah.dart';
import 'package:oguz_dokma/hat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Yukle(),
    );
  }
}

class Yukle extends StatelessWidget {
  const Yukle({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/suratlar/logo_1.gif', height: 250, width: 400),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      nextScreen: const Esasy(),
      splashIconSize: 250,
      duration: 7000,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
