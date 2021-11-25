// ignore_for_file: avoid_print

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipit/models/user.model.dart';
import 'package:clipit/services/user.service.dart';
import 'package:clipit/utilities/shared_widgets.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:clipit/utilities/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) => ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: signUpKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText("Clip It",
                              textStyle: TextStyle(
                                fontSize: 48,
                                color: Theme.of(context).primaryColor,
                              ),
                              speed: const Duration(milliseconds: 300)),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SharedWidgets.textFormField(
                        context,
                        controller: emailController,
                        title: "Email",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: CustomValidators.validateEmail,
                      ),
                      SharedWidgets.textFormField(
                        context,
                        controller: passwordController,
                        title: "Password",
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        validator: CustomValidators.validatePassword,
                      ),
                      SharedWidgets.argonButton(context, btnText: "SIGN UP",
                          onTap: () {
                        addUser();
                      }),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: "Aready have an account ? ",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                          TextSpan(
                              text: "Login",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, "/login");
                                })
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addUser() async {
    try {
      if (signUpKey.currentState!.validate()) {
        UserModel user = UserModel();
        user.email = emailController.text.trim();
        user.password = passwordController.text.trim();
        await UserService().addUser(user).then((userResponseModel) {
          if (Utility.isNotNullEmptyOrFalse(userResponseModel)) {
            SharedWidgets.successToast('Registered Successfully.');
            Navigator.pushNamed(context, '/dashboard');
          }
        });
      }
    } catch (e) {
      SharedWidgets.somethingWentWrong();
      print(e);
    }
  }
}
