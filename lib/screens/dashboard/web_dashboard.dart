// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:clipit/models/session.model.dart';
import 'package:clipit/services/session.service.dart';
import 'package:clipit/utilities/constants.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sse_client/sse_client.dart';

class WebDashboard extends StatefulWidget {
  const WebDashboard({Key? key}) : super(key: key);

  @override
  _WebDashboardState createState() => _WebDashboardState();
}

class _WebDashboardState extends State<WebDashboard> {
  bool isLoading = true;
  bool isFetching = false;
  String sessionId = "";
  String sessionContent = "";
  late Stream sse;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  getSession() async {
    setState(() {
      isLoading = true;
    });
    await SessionService().getNewSession().then((session) {
      if (Utility.isNotNullEmptyOrFalse(session)) {
        setState(() {
          sessionId = session!.sessionId;
        });
        subscribeSSE();
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  subscribeSSE() async {
    print("Subscribing. SSE.");
    try {
      sse = SseClient.connect(
              Uri.parse("${Constants.baseUrl}/sessions/$sessionId"))
          .stream!
          .asBroadcastStream();
      // if (sse != null && !await sse.isEmpty) {
      //   isFetching = true;
      // }
      sse.asBroadcastStream().listen((event) {
        // print(event.toString());
        var data = json.decode(event.toString());
        SessionModel session = SessionModel.fromJson(data['session']);
        if (Utility.isNotNullEmptyOrFalse(session.userID) &&
            session.userID != 0) {
          isFetching = true;
        }
        setState(() {
          sessionContent = session.content;
        });
        print(session);
      });
    } catch (e) {
      print("Caught $e");
    }
  }

  Future<void> refreshWidget() async {
    getSession();
  }

  @override
  void dispose() {
    if (sse != null) sse.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : RefreshIndicator(
                onRefresh: refreshWidget,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Utility.isNotNullEmptyOrFalse(sessionId)
                      ? isFetching
                          ? Card(
                              child: Text(sessionContent),
                            )
                          : SizedBox(
                              height: 300,
                              width: 300,
                              child: QrImage(data: sessionId),
                            )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Something went wrong.",
                              style: TextStyle(fontSize: 24),
                            ),
                            TextButton(
                                onPressed: () => refreshWidget(),
                                child: const Text("Refresh"))
                          ],
                        ),
                ),
              ),
      ),
    );
  }
}
