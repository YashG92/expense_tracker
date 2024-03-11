import 'dart:async';

import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/widgets/auth_gate.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds:3 ), // Change the duration as per your requirement
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthGate(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your app's logo or name widget here
            // Example:
            Image.asset('assets/images/logo.png',
              width: 150,
              height: 150,
              // You can customize width and height according to your logo
            ),
            // You can add a loading indicator if necessary
            
          ],
        ),
      ),
    );
  }
}