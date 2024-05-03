import 'dart:async';

import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override void initState()
  {
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacementNamed(context, AppRoute.homescreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Image.asset("assets/images/kohler_konnect_logo.png")),
      ),
    );
  }
}
