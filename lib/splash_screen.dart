import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipit/services/user.service.dart';
import 'package:clipit/utilities/custom_dialogs.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<ConnectivityResult> connectivityListener;

  @override
  void initState() {
    super.initState();
    kIsWeb ? goToDashboard() : checkForRoute();
  }

  @override
  void dispose() {
    connectivityListener.cancel();
    super.dispose();
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

  void checkForRoute() async {
    // Check internet connection at start.
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        CustomDialogs.connectivityDialog(context);
      }
    });

    // If internet is not available then, this Listener will make sure to keep user out put app.
    connectivityListener =
        Connectivity().onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        CustomDialogs.connectivityDialog(context);
      }
    });

    var token = await Utility.getCookies('token');
    if (Utility.isNotNullEmptyOrFalse(token)) {
      UserService().me(token).then((user) {
        if (Utility.isNotNullEmptyOrFalse(user)) {
          Utility.storeCookie('id', user!.id.toString());
          Utility.storeCookie('email', user.email);

          goToDashboard();
        }
      });
    } else {
      goToLogin();
    }
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
