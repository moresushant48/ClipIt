import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WebDashboard extends StatefulWidget {
  const WebDashboard({Key? key}) : super(key: key);

  @override
  _WebDashboardState createState() => _WebDashboardState();
}

class _WebDashboardState extends State<WebDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: QrImage(data: "sushant"),
        ),
      ),
    );
  }
}
