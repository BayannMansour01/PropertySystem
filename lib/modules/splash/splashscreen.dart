import 'dart:async';

import 'package:flutter/material.dart';

import '../LoginPage/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

@override
class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return login();
        }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Center(
            child: Image(
                image: AssetImage('assets/images/icon.png'),
                height: 100,
                width: 100),
          ),
        ],
      )),
    );
  }
}
