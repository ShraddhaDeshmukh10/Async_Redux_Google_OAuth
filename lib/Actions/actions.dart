import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_oauth/appstate.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenti extends ReduxAction<AppState> {
  final FirebaseAuth auth01;
  final GoogleSignIn googleSignIn;

  Authenti({required this.auth01, required this.googleSignIn});

  @override
  Future<AppState> reduce() async {
    final user = await signInWithGoogle();
    if (user != null) {
      dispatch(NavigateAction.pushNamed(""));
    }
    return state;
  }

  Future<User?> signInWithGoogle() async {
    try {
      /// Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Page()));
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await auth01.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }
}
