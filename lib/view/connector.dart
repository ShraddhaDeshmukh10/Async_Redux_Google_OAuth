import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:google_oauth/Actions/actions.dart';
import 'package:google_oauth/Model/currentuser.dart';
import 'package:google_oauth/appstate.dart';
import 'package:google_oauth/view/login_page.dart';

class AuthServiceConnector extends StatelessWidget {
  final CurrentUser? currentUser;
  const AuthServiceConnector({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      vm: () => Factory(this),
      builder: (context, vm) => LoginPage(googleSignIn: vm.googleSignIn),
    );
  }
}

class ViewModel extends Vm {
  final void Function() googleSignIn;
  final CurrentUser currentUser;

  ViewModel({
    required this.googleSignIn,
    required this.currentUser,
  }) : super(equals: [currentUser]);
}

class Factory extends VmFactory<AppState, AuthServiceConnector, ViewModel> {
  Factory(connector) : super(connector);

  @override
  ViewModel? fromStore() => ViewModel(
        currentUser: state.currentUser ?? CurrentUser(),
        googleSignIn: () => dispatch(Authenti()),
      );
}
