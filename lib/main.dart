import 'package:clipit/screens/login.dart';
import 'package:clipit/screens/signup.dart';
import 'package:clipit/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF9c27b0),
        primaryColorLight: const Color(0xFFd05ce3),
        primaryColorDark: const Color(0xFF6a0080),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: "/",
      onGenerateRoute: routes,
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
            child: const SplashScreen(), type: PageTransitionType.fade);
      case '/dashboard':
        return PageTransition(
            child: const SplashScreen(), type: PageTransitionType.fade);
      case '/login':
        return PageTransition(
            child: const Login(), type: PageTransitionType.fade);
      case '/signup':
        return PageTransition(
            child: const Signup(), type: PageTransitionType.fade);
      default:
        return PageTransition(
            child: const SplashScreen(), type: PageTransitionType.fade);
    }
  }
}
