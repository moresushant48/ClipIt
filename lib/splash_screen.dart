import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkForRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText("Clip It",
                textStyle: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
                speed: const Duration(milliseconds: 300)),
          ],
        ),
      ),
    );
  }

  void checkForRoute() {
    goToLogin();
  }

  goToDashboard() {
    return Timer(const Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(context, "/dashboard"));
  }

  goToLogin() {
    return Timer(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, "/login"));
  }
}
