import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipit/utilities/shared_widgets.dart';
import 'package:clipit/utilities/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //

  final loginKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) => ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText("Clip It",
                              textStyle: const TextStyle(
                                fontSize: 48,
                                color: Colors.white,
                              ),
                              speed: const Duration(milliseconds: 300)),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SharedWidgets.textFormField(
                        controller: emailController,
                        title: "Email",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: CustomValidators.validateEmail,
                      ),
                      SharedWidgets.textFormField(
                        controller: passwordController,
                        title: "Password",
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        validator: CustomValidators.validatePassword,
                      ),
                      SharedWidgets.argonButton(context,
                          btnText: "LOGIN", onTap: () {}),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          TextSpan(
                              text: "Sign Up",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, "/signup");
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
}
