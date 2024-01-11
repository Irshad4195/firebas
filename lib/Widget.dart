import 'package:flutter/material.dart';

class UiHelper {
  static customTextField(
      String label, bool isPassword, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelStyle: const TextStyle(
              color: Color.fromARGB(255, 125, 3, 166), fontSize: 20),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 125, 3, 166), width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 125, 3, 166), width: 2.0),
          ),
        ),
      ),
    );
  }

  static CustomElevatedButton(String text, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(const Size(double.maxFinite, 50)),
          elevation: MaterialStateProperty.all(0.1),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                // Color when the button is pressed
                return Colors.deepPurple.withOpacity(0.2);
              } else {
                // Default color
                return const Color.fromARGB(255, 245, 241, 253);
              }
            },
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
