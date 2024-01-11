import 'package:flutter/material.dart';
import 'package:flutter_firebase/Widget.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/email_login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignUp(String email, String password) async {
    if (email == "" && password == "" || email == "" || password == "") {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Enter Required Fields"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                )
              ],
            );
          });
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          AlertDialog(
            title: const Text("User Created"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
          return null;
        });
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(e.code.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          UiHelper.customTextField("Enter Email", false, emailController),
          UiHelper.customTextField("Enter Password", true, passwordController),
          UiHelper.CustomElevatedButton("SignUp", () {
            SignUp(emailController.text.toString(),
                passwordController.text.toString());
          }),
          UiHelper.CustomElevatedButton("SignIn", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EmailLoginOption()));
          }),
          UiHelper.CustomElevatedButton("Login with Phone", () {}),
        ],
      )),
    );
  }
}
