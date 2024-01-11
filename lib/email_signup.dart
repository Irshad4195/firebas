import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Widget.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/email_login.dart';
import 'package:flutter_firebase/home_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  SignUp(String email, String password, String name) async {
    if (email == "" && password == "" && name == "" ||
        email == "" ||
        password == "" ||
        name == "") {
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
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
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
              }).then((value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }).then((value) {
            FirebaseFirestore.instance.collection("Users").doc(email).set({
              "Name": nameController.text.toString(),
              "Email": emailController.text.toString()
            });
          }).then((value) {
            log("User Created");
          });
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
          UiHelper.customTextField("Enter Profile Name", false, nameController),
          UiHelper.customTextField("Enter Email", false, emailController),
          UiHelper.customTextField("Enter Password", true, passwordController),
          UiHelper.CustomElevatedButton("SignUp", () {
            SignUp(
                emailController.text.toString(),
                passwordController.text.toString(),
                nameController.text.toString());
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
