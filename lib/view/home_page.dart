import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "You Landed Succesfully!!!!",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
