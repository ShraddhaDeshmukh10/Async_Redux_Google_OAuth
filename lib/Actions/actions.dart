import 'dart:async';
import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_oauth/Model/currentuser.dart';
import 'package:google_oauth/appstate.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenti extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? currentUser = userCredential.user;

      if (currentUser != null) {
        final currentUserData = CurrentUser.fromFirebaseUser(currentUser);
        print("User signed in: ${currentUserData.email}");
        return state.copy(currentUser: currentUserData);
      } else {
        print("User credential is null after sign-in.");
        return state;
      }
    } catch (error) {
      print("Error during Google sign-in: $error");
      return state.copy(currentUser: CurrentUser());
    }
  }
}
