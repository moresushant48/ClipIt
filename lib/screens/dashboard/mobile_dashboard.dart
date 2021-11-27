import 'package:clipit/screens/qr_scanner.dart';
import 'package:clipit/utilities/custom_images.dart';
import 'package:clipit/utilities/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MobileDashboard extends StatefulWidget {
  const MobileDashboard({Key? key}) : super(key: key);

  @override
  _MobileDashboardState createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
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
      ),
    );
  }
}
