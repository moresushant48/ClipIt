import 'package:clipit/services/session.service.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WebDashboard extends StatefulWidget {
  const WebDashboard({Key? key}) : super(key: key);

  @override
  _WebDashboardState createState() => _WebDashboardState();
}

class _WebDashboardState extends State<WebDashboard> {
  bool isLoading = true;
  String sessionId = "";

  @override
  void initState() {
    super.initState();
    getSession();
  }

  getSession() {
    setState(() {
      isLoading = true;
    });
    SessionService().getNewSession().then((session) {
      if (Utility.isNotNullEmptyOrFalse(session)) {
        setState(() {
          sessionId = session!.sessionId;
        });
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> refreshWidget() async {
    getSession();
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
                      ? SizedBox(
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
