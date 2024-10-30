import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_oauth/appstate.dart';
import 'package:google_oauth/view/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceConnector extends StatelessWidget {
  const AuthServiceConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      vm: () => Factory(),
      builder: (context, vm) => Login_Page(
        authentication: vm.auth01,
        google: vm.googleSignIn,
      ),
    );
  }
}

class ViewModel extends Vm {
  final FirebaseAuth auth01;
  final GoogleSignIn googleSignIn;

  ViewModel({
    required this.auth01,
    required this.googleSignIn,
  }) : super(equals: [auth01, googleSignIn]);
}

class Factory extends VmFactory<AppState, AuthServiceConnector, ViewModel> {
  Factory();

  @override
  ViewModel fromStore() => ViewModel(
        auth01: state.auth01,
        googleSignIn: state.googleSignIn,
      );
}
