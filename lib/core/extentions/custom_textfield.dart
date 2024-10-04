import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final double? hintTextSize;
  final double? labelTextSize;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.hintTextColor,
    this.hintTextSize,
    this.labelTextSize,
    this.labelText,
    this.labelTextColor,
    this.enabledBorderColor = Colors.black,
    this.focusedBorderColor,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText ?? "Enter your message...",
        labelText: labelText ?? "Your details here",
        labelStyle: TextStyle(
          color: labelTextColor ?? Theme.of(context).primaryColor,
          fontSize: labelTextSize,
        ),
        hintStyle: TextStyle(
          color: hintTextColor ?? Theme.of(context).primaryColor,
          fontSize: hintTextSize,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: enabledBorderColor!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: focusedBorderColor ?? Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: enabledBorderColor!,
            width: 2,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
