import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.hintStyle,
    this.labelStyle,
    this.textStyle,
    this.borderRadius = 6.0,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
  });

  final String hint;
  final String label;
  final bool isPassword;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        labelText: label,
        labelStyle: labelStyle,
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
      ),
    );
  }
}
