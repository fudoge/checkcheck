import 'package:checkcheck/AuthService.dart';

class SignInButtonViewModel {
  void googleSignIn() {
    AuthService().signInWithGoogle();
  }

  void appleSignIn() {}
}
