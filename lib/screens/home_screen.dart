import 'dart:ffi';

import 'package:expense_tracker/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            "Hello",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  logOut();
                },
                icon: isLogoutLoading
                    ? CircularProgressIndicator()
                    : Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ))
          ]),
      body: Container(
          width: double.infinity,
          color: Colors.lightBlue,
          child: const Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Balance",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "100000",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
