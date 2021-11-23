import 'package:clipit/screens/qr_scanner.dart';
import 'package:clipit/utilities/custom_images.dart';
import 'package:clipit/utilities/shared_widgets.dart';
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
  Widget buildWebView(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: QrImage(data: "sushant"),
      ),
    );
  }

  Widget buildMobileView(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: constraints,
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottieBuilder.asset(CustomImages.qrLottie),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text(
                //     "Scan QR",
                //     style: TextStyle(
                //       // color: Theme.of(context).primaryColor,
                //       fontSize: 16.0,
                //     ),
                //   ),
                // )
                SharedWidgets.argonButton(
                  context,
                  btnText: "Scan QR",
                  onTap: () async {
                    // Future.delayed(const Duration(seconds: 2));
                    Barcode? result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QrScanner(),
                        ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text("Clip It"),
      ),
      body: kIsWeb ? buildWebView(context) : buildMobileView(context),
    );
  }
}
