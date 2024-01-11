import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Widget.dart';
import 'package:flutter_firebase/home_screen.dart';

class EmailLoginOption extends StatefulWidget {
  const EmailLoginOption({super.key});

  @override
  State<EmailLoginOption> createState() => _EmailLoginOptionState();
}

class _EmailLoginOptionState extends State<EmailLoginOption> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignIn(String email, String password) async {
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
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                    child: const Text("OK"),
                  )
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
          UiHelper.CustomElevatedButton("Login", () {
            SignIn(emailController.text.toString(),
                passwordController.text.toString());
          }),
          UiHelper.CustomElevatedButton("Login with Phone", () {}),
        ],
      )),
    );
  }
}
