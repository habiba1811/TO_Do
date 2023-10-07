import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do/styles/colors.dart';

import '../layout/home_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName='splashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), NavegateToTasksBage);
  }
  void NavegateToTasksBage(){
    Navigator.pushNamedAndRemoveUntil(context, HomeLayout.routeName, (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mintGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/logo.png')),
        ],
      ),
    );
  }
}
