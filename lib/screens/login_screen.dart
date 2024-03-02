// import 'package:expense_tracker/screens/dashboard.dart';
import 'package:expense_tracker/screens/forgot_screen.dart';
import 'package:expense_tracker/screens/sign_up.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/utils/appvalidator.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var isLoader = false;

  var authService = AuthService();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      await authService.login(data, context);

      setState(() {
        isLoader = false;
      });
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                        'Login Account',
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
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        _buildInputDecoration('Email', Icons.email_rounded),
                    validator: appValidator.validateEmail,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration('Password', Icons.lock),
                    validator: appValidator.validatePassword,
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
                      onPressed: () {
                        isLoader ? "" : _submitForm();
                      },
                      child: isLoader
                          ? Center(child: CircularProgressIndicator())
                          : Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                    child: Text(
                      'Create new account',
                      style: TextStyle(
                          color: Color.fromARGB(255, 241, 89, 0), fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Forgot(),
                          ));
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 241, 89, 0), fontSize: 25),
                    ),
                  ),
                ],
              )),
        ),
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
