import 'package:checkcheck/view/LoginPageView.dart';
import 'package:checkcheck/viewModel/AuthViewViewModel.dart';
import 'package:flutter/material.dart';
import 'HomePageView.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: AuthViewViewModel().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePageView();
          } else {
            return const LoginPageView();
          }
        },
      ),
    );
  }
}
