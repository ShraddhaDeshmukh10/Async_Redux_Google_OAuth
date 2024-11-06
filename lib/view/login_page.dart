import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_oauth/Resources/resources.dart';

class LoginPage extends StatefulWidget {
  final void Function() googleSignIn;
  const LoginPage({super.key, required this.googleSignIn});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> userLogin() async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      Navigator.pushNamed(context, Routes.home);
    } on FirebaseAuthException catch (e) {
      String message = (e.code == 'invalid-credential')
          ? 'Invalid Login Credentials'
          : e.message!;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              child: TextFormField(
                controller: passController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            ElevatedButton(onPressed: userLogin, child: Text('Login')),
            TextButton(
                onPressed: widget.googleSignIn,
                child: Text('Sign in with Google')),
          ],
        ),
      ),
    );
  }
}
