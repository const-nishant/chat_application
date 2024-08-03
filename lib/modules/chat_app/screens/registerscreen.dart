import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onPressed;
  const RegisterScreen({
    super.key,
    required this.onPressed,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  final usernametextcontroller = TextEditingController();
  final phonetextcontroller = TextEditingController();
  final emailtextcontroller = TextEditingController();
  final passwordtextcontroller = TextEditingController();
  final confirmpasswordtextcontroller = TextEditingController();

  void register(BuildContext context) async {
    // Auth services
    final authServices = Authservices();

    // Try register
    if (formkey.currentState!.validate()) {
      try {
        await authServices.registerWithEmailandPassword(
          emailtextcontroller.text,
          passwordtextcontroller.text,
          phonetextcontroller.text,
          usernametextcontroller.text,
        );
      } on FirebaseAuthException catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.code),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Icon(
                    Icons.message,
                    size: 60,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  //welcome back message
                  Text(
                    "Welcome back!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  //username textfield
                  Commontextfield(
                    controller: usernametextcontroller,
                    readOnly: false,
                    obscureText: false,
                    hintText: "Username",
                    maxLength: 10,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //email textfield
                  Commontextfield(
                    controller: emailtextcontroller,
                    readOnly: false,
                    obscureText: false,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //phone textfield
                  Commontextfield(
                    controller: phonetextcontroller,
                    readOnly: false,
                    obscureText: false,
                    hintText: "Phone Number",
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //password textfield
                  Commontextfield(
                    controller: passwordtextcontroller,
                    readOnly: false,
                    obscureText: true,
                    hintText: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //confirm password textfield
                  Commontextfield(
                    controller: confirmpasswordtextcontroller,
                    readOnly: false,
                    obscureText: true,
                    hintText: "Confirm Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value != passwordtextcontroller.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //register button
                  LargeButtons(
                    text: "Sign Up",
                    bordercolor: Theme.of(context).colorScheme.primary,
                    textcolor: Theme.of(context).colorScheme.primary,
                    backgroundcolor: Theme.of(context).colorScheme.secondary,
                    onPressed: () => register(context),
                  ),

                  const SizedBox(height: 20),

                  //already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onPressed,
                        child: Text(
                          "Login now",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
