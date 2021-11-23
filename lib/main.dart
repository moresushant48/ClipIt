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
    Color primaryColor = const Color(0xFF9c27b0);
    Color primaryColorLight = const Color(0xFFd05ce3);
    Color primaryColorDark = const Color(0xFF6a0080);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: primaryColor,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: primaryColor,
        primaryColorLight: primaryColorLight,
        primaryColorDark: primaryColorDark,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
        ),
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: primaryColorLight,
        ),
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
