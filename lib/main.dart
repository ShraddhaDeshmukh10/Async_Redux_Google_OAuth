import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:async_redux/async_redux.dart';
import 'package:google_oauth/Actions/actions.dart';
import 'package:google_oauth/Resources/resources.dart';
import 'package:google_oauth/appstate.dart';
import 'package:google_oauth/view/home_page.dart';
import 'package:google_oauth/view/login_page.dart';
import 'firebase_options.dart';

late Store<AppState> store;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var state = AppState.initialState();
  store = Store<AppState>(initialState: state);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Routes.login,
        routes: {
          Routes.login: (context) => LoginPage(googleSignIn: () {
                StoreProvider.dispatch<AppState>(context, Authenti());
              }),
          Routes.home: (context) => Home_Page(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.home:
              return MaterialPageRoute(builder: (context) => Home_Page());
            case Routes.login:
              return MaterialPageRoute(
                  builder: (context) => LoginPage(googleSignIn: () {
                        StoreProvider.dispatch<AppState>(context, Authenti());
                      }));
            default:
              return MaterialPageRoute(
                  builder: (context) => LoginPage(googleSignIn: () {
                        StoreProvider.dispatch<AppState>(context, Authenti());
                      }));
          }
        },
      ),
    );
  }
}
