import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SharedWidgets {
  static void empty() {}

  static void somethingWentWrong() => Fluttertoast.showToast(
      msg: "Something went wrong.", backgroundColor: Colors.red);
  static void successToast(String msg) =>
      Fluttertoast.showToast(msg: msg, backgroundColor: Colors.green);
  static void failureToast(String msg) =>
      Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red);

  static Widget textFormField(BuildContext context,
      {
      // options
      controller,
      String title = "",
      bool obscureText = false,
      TextInputAction textInputAction = TextInputAction.next,
      TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter> inputFormatters = const [],
      validator
      //
      }) {
    return Container(
      width: kIsWeb ? 400 : null,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utility.isNotNullEmptyOrFalse(title)
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  ),
                )
              : Container(),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey[290],
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: Utility.isNotNullEmptyOrFalse(textInputAction)
                ? textInputAction
                : null,
            inputFormatters: Utility.isNotNullEmptyOrFalse(inputFormatters)
                ? inputFormatters
                : null,
            validator: validator,
          ),
        ],
      ),
    );
  }

  static Widget argonButton(
    BuildContext context, {
    String btnText = "",
    double height = 0.0,
    double width = 0.0,
    required Function onTap,
  }) {
    return Container(
      width: kIsWeb ? 400 : null,
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: ArgonButton(
        height: height != 0.0 ? height : 50,
        width: width != 0.0 ? width : MediaQuery.of(context).size.width * 0.8,
        roundLoadingShape: true,
        color: Theme.of(context).primaryColor,
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        borderRadius: 40.0,
        onTap: (startLoading, stopLoading, btnState) {
          if (btnState != ButtonState.Busy) {
            startLoading();
            Utility.isNotNullEmptyOrFalse(onTap) ? onTap() : null;
            stopLoading();
          }
        },
      ),
    );
  }
}
