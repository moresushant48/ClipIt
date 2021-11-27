import 'package:clipit/screens/dashboard/mobile_dashboard.dart';
import 'package:clipit/screens/dashboard/web_dashboard.dart';
import 'package:clipit/screens/qr_scanner.dart';
import 'package:clipit/utilities/custom_images.dart';
import 'package:clipit/utilities/shared_widgets.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text("Clip It"),
        actions: [
          PopupMenuButton(
            onSelected: _select,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            enableFeedback: true,
            itemBuilder: (BuildContext context) {
              return menu.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: kIsWeb ? const WebDashboard() : const MobileDashboard(),
    );
  }

  final menu = const {'Sign Out'};
  _select(String choice) {
    switch (choice) {
      case 'Sign Out':
        Utility.logout(context);
        break;
      default:
    }
  }
}
