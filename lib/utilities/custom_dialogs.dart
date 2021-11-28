import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:flutter/material.dart';

class CustomDialogs {
  static Future<Widget?> connectivityDialog(BuildContext context,
      {String image = ''}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Utility.isNotNullEmptyOrFalse(image)
                      ? Image(
                          image: AssetImage(image),
                          height: 90.0,
                          // width: 90.0,
                          fit: BoxFit.fill,
                        )
                      : Container(),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      "Oops!",
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 15.0),
                    child: Text(
                      "No Internet Connection",
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: ArgonButton(
                      roundLoadingShape: true,
                      width: MediaQuery.of(context).size.width * 0.78,
                      height: MediaQuery.of(context).size.width * 0.1,
                      color: Theme.of(context).primaryColor,
                      borderRadius: 40.0,
                      child: const Text(
                        "Retry",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'SFpro',
                            fontWeight: FontWeight.w500),
                      ),
                      // loader: Container(
                      //   padding: EdgeInsets.all(10),
                      //   child: SpinKitDoubleBounce(
                      //     color: Colors.white,
                      //     size: 16,
                      //   ),
                      // ),
                      onTap: (startLoading, stopLoading, btnState) {
                        startLoading();
                        Future.delayed(const Duration(seconds: 2))
                            .then((value) {
                          stopLoading();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Navigator.defaultRouteName, (route) => false);
                        });
                        // stopLoading();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
