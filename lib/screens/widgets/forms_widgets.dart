import 'package:flutter/material.dart';
import 'package:green_harbour/constants.dart';

Text bulletText(String text) {
  return Text(
    "\u2022 $text",
    style: const TextStyle(color: Colors.black, fontSize: 14),
  );
}

SizedBox height(double height) {
  return SizedBox(
    height: height,
  );
}

Widget appTextfield(
    {required String title,
    required String hintText,
    required TextEditingController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      height(4),
      TextFormField(
        controller: controller,
        cursorColor: primaryGreen,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: primaryGreen, // Set the border color when focused
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500)),
      )
    ],
  );
}
