import 'package:flutter/material.dart';
import '../exports.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
//initally,show login
  bool showLogin = true;

//toggle between login and register
  void toggleScreens() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginScreen(
        onPressed: toggleScreens,
      );
    } else {
      return RegisterScreen(
        onPressed: toggleScreens,
      );
    }
  }
}
