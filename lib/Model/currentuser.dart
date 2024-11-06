import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  String? email;
  String? password;

  CurrentUser({this.email, this.password});

  factory CurrentUser.fromFirebaseUser(User user) {
    return CurrentUser(
      email: user.email,
    );
  }
}
