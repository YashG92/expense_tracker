import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/utils/appvalidator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  Forgot({super.key});

  @override
  State<Forgot> createState() => _LoginState();
}

class _LoginState extends State<Forgot> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final forgetPasswordController = TextEditingController();

  var authService = AuthService();

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                ),
                SizedBox(
                    width: 250,
                    child: Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: forgetPasswordController,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                      _buildInputDecoration('Email', Icons.email_rounded),
                  validator: appValidator.validateEmail,
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 241, 89, 0)),
                    onPressed: () async {
                      var forgotEmail = forgetPasswordController.text.trim();
                      try {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: forgotEmail)
                            .then(
                              (value) => {
                                print("email sent"),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                ),
                              },
                            );
                      } on FirebaseAuthException catch (e) {
                        print("Error $e");
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String value, IconData iconData) {
    return InputDecoration(
        fillColor: Color(0xAA494A59),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x35949494),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        labelStyle: TextStyle(color: Color(0xFF949494)),
        labelText: value,
        suffixIcon: Icon(
          iconData,
          color: Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }
}
