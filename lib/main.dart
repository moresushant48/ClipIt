import 'package:clipit/screens/auth/login.dart';
import 'package:clipit/screens/auth/signup.dart';
import 'package:clipit/screens/dashboard/dashboard.dart';
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
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.dark,
        primarySwatch: Colors.teal,
        backgroundColor: const Color(0xFFF2F2F2),
      ),
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
            child: const Dashboard(), type: PageTransitionType.fade);
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
