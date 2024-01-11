import 'package:flutter/material.dart';
import 'package:flutter_firebase/Widget.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("Welcome"),
          UiHelper.customTextField(
              "Enter Phone Number", false, phoneController),
          UiHelper.CustomElevatedButton("Genrate Otp", () {}),
          UiHelper.CustomElevatedButton("Resend", () {}),
        ],
      )),
    );
  }
}
