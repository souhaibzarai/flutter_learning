import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  @override
  Widget build(context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isPassword,
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
    );
  }
}
