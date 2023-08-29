import 'package:checkcheck/viewModel/SignInButtonViewModel.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatefulWidget {
  final String text;
  final String image;
  final bool isGoogleSignIn;
  const SignInButton(
      {super.key,
      required this.text,
      required this.image,
      required this.isGoogleSignIn});

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isGoogleSignIn
          ? () {
              SignInButtonViewModel().googleSignIn();
            }
          : () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        height: 60,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(
              width: 20,
            ),
            Text(widget.text)
          ],
        ),
      ),
    );
  }
}
