import 'package:flutter/material.dart';

import 'SignInButton.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo..
            Icon(
              Icons.calendar_month,
              size: 100,
            ),
            SizedBox(
              height: 50,
            ),
            Text("Hello! Manage with checkcheck!"),
            SizedBox(
              height: 50,
            ),

            // Google Sign In..
            SignInButton(
              image: "",
              isGoogleSignIn: true,
              text: "Sign In with Google...",
            ),

            SizedBox(
              height: 10,
            ),

            // Apple Sign In..
            SignInButton(
              image: "",
              isGoogleSignIn: false,
              text: "Sign In with Apple...",
            )
          ],
        ),
      )),
    );
  }
}
