import 'package:google_oauth/Model/currentuser.dart';

class AppState {
  final CurrentUser? currentUser;
  AppState({this.currentUser});

  AppState copy({
    CurrentUser? currentUser,
  }) {
    return AppState(
      currentUser: currentUser ?? this.currentUser,
    );
  }

  static AppState initialState() => AppState(currentUser: null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState && currentUser == other.currentUser;

  @override
  int get hashCode => currentUser.hashCode;
}
