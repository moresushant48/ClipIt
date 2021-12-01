// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:clipit/models/session.model.dart';
import 'package:clipit/screens/qr_scanner.dart';
import 'package:clipit/services/session.service.dart';
import 'package:clipit/utilities/constants.dart';
import 'package:clipit/utilities/custom_images.dart';
import 'package:clipit/utilities/shared_widgets.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sse_client/sse_client.dart';

class MobileDashboard extends StatefulWidget {
  const MobileDashboard({Key? key}) : super(key: key);

  @override
  _MobileDashboardState createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
  bool isFetching = false;
  String content = '';
  late Stream sse;

  @override
  void initState() {
    super.initState();
  }

  subscribeSSE(String? sessionId) async {
    var userID = await Utility.getCookies('id');
    SessionService().setUserForSession(sessionId!).then((value) async {
      if (value) {
        print("Subscribing SSE..");
        try {
          sse = SseClient.connect(
                  Uri.parse("${Constants.baseUrl}/sessions/$sessionId"))
              .stream!
              .asBroadcastStream();
          if (sse != null && !await sse.isEmpty) {
            isFetching = true;
          }
          sse.asBroadcastStream().listen((event) {
            var data = json.decode(event.toString());
            SessionModel session = SessionModel.fromJson(data['session']);
            setState(() {
              content = session.content;
            });
          });
        } catch (e) {
          print("Caught $e");
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: constraints,
            child: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: isFetching
                  ? Card(
                      child: Text(Utility.isNotNullEmptyOrFalse(content)
                          ? content
                          : 'Welcome to Clip IT...!'),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(CustomImages.qrLottie),
                        SharedWidgets.argonButton(
                          context,
                          btnText: "Scan QR",
                          onTap: () async {
                            Future.delayed(const Duration(seconds: 2));
                            Barcode? result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QrScanner(),
                                ));
                            subscribeSSE(result!.code);
                          },
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
