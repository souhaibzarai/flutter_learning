import 'package:flutter/material.dart';

class TripFormField extends StatelessWidget {
  const TripFormField({
    super.key,
    this.isObscure,
    this.isReadOnly,
    this.length,
    required this.text,
    required this.controller,
  });

  final bool? isObscure;
  final bool? isReadOnly;
  final int? length;
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: length,
      obscureText: isObscure ?? false,
      readOnly: isReadOnly ?? false,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.black87,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: const Color.fromARGB(147, 231, 84, 84),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Color.fromARGB(255, 229, 217, 242),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Color.fromARGB(170, 205, 193, 255),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$text is missing';
        }
        return null;
      },
    );
  }
}
