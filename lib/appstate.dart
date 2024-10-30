import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppState {
  final FirebaseAuth auth01;
  final GoogleSignIn googleSignIn;
  AppState({required this.auth01, required this.googleSignIn});

  AppState copy({
    FirebaseAuth? auth01,
    GoogleSignIn? googleSignIn,
  }) {
    return AppState(
        auth01: auth01 ?? this.auth01,
        googleSignIn: googleSignIn ?? this.googleSignIn);
  }

  static AppState initialState() =>
      AppState(auth01: FirebaseAuth.instance, googleSignIn: GoogleSignIn());
}
