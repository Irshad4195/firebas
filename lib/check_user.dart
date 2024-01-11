import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/email_signup.dart';
import 'package:flutter_firebase/home_screen.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return checkuser();
  }
}

checkuser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return HomeScreen();
  } else {
    return SignUp();
  }
}
