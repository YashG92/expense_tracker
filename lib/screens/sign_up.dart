import 'package:expense_tracker/screens/dashboard.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/utils/appvalidator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _phoneController = TextEditingController();

  var authService = AuthService();
  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "username": _userNameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "password": _passwordController.text,
      };
      await authService.createUser(data, context);


      setState(() {
        isLoader = false;
      });
      // ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
      //     const SnackBar(content: Text('Form submitted sucessfully')));
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80.0,
                  ),
                  const SizedBox(
                      width: 250,
                      child: Text(
                        'Create new account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                    controller: _userNameController,
                    style: TextStyle(color: Colors.white),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration('Username', Icons.person),
                    validator: appValidator.validateUsername,
                  ),
                  const SizedBox(
                    height: 16.0,
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
                    controller: _phoneController,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        _buildInputDecoration('Phone Number', Icons.phone),
                    validator: appValidator.validatePhoneNumber,
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 241, 89, 0)),
                      onPressed: () {
                        isLoader ? "" : _submitForm();
                      },
                      child: isLoader
                          ? const Center(child: CircularProgressIndicator())
                          : const Text(
                              'Create',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text(
                      'Login',
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
