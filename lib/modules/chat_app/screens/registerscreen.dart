import 'package:cloud_firestore/cloud_firestore.dart';
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
  final phonetextcontroller = TextEditingController();
  final emailtextcontroller = TextEditingController();
  final passwordtextcontroller = TextEditingController();
  final confirmpasswordtextcontroller = TextEditingController();

  void register(BuildContext context) async {
    // Auth services
    final authServices = Authservices();

    // Try register
    if (passwordtextcontroller.text == confirmpasswordtextcontroller.text) {
      try {
        await authServices.registerWithEmailandPassword(
          emailtextcontroller.text,
          passwordtextcontroller.text,
        );

        // Create user document
        final currentUser = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.uid)
            .set({
          'uid': currentUser.uid,
          'email': emailtextcontroller.text,
          'phone': phonetextcontroller.text,
        });
      } on FirebaseAuthException catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.code),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password does not match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
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
                //email textfield
                Commontextfield(
                  controller: emailtextcontroller,
                  readOnly: false,
                  obscureText: false,
                  hintText: "Email",
                ),
                const SizedBox(height: 20),
                //phone textfield
                Commontextfield(
                  controller: phonetextcontroller,
                  readOnly: false,
                  obscureText: false,
                  hintText: "Phone Number",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                //password textfield
                Commontextfield(
                  controller: passwordtextcontroller,
                  readOnly: false,
                  obscureText: true,
                  hintText: "Password",
                ),
                const SizedBox(height: 20),
                //confirm password textfield
                Commontextfield(
                  controller: confirmpasswordtextcontroller,
                  readOnly: false,
                  obscureText: true,
                  hintText: "Confirm Password",
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
    );
  }
}
