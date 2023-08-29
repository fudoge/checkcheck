import 'package:firebase_auth/firebase_auth.dart';

class AuthViewViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
