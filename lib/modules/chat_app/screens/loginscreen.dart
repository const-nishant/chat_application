import 'package:chat_application/modules/chat_app/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onPressed;
  const LoginScreen({
    super.key,
    required this.onPressed,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailtextcontroller = TextEditingController();
  final passwordtextcontroller = TextEditingController();

  void login(BuildContext context) async {
    //auth services
    final authservices = Authservices();

    //try login
    try {
      await authservices.signInWithEmailandPassword(
        emailtextcontroller.text,
        passwordtextcontroller.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
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
                obscureText: false,
                hintText: "Email",
                controller: emailtextcontroller,
                readOnly: false,
              ),
        
              const SizedBox(height: 18),
              //password textfield
              Commontextfield(
                obscureText: true,
                hintText: "Password",
                controller: passwordtextcontroller,
                readOnly: false,
                keyboardType: TextInputType.visiblePassword,
              ),
        
              const SizedBox(height: 14),
              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forgot password ?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              //login button
              LargeButtons(
                onPressed: () => login(context),
                text: "Login",
                bordercolor: Theme.of(context).colorScheme.primary,
                textcolor: Theme.of(context).colorScheme.primary,
                backgroundcolor: Theme.of(context).colorScheme.secondary,
              ),
        
              const SizedBox(height: 14),
              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member ?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: widget.onPressed,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
