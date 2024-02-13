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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
              Container(
                padding:
                    EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    CardOne(
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    CardOne(
                      color: Colors.red,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class CardOne extends StatelessWidget {
  const CardOne({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "Credit",
                    style: TextStyle(color: color, fontSize: 30),
                  ),
                  Text("5000")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
