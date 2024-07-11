import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  final int minLines;
  final int maxLines;
  final TextInputType? keyboardType;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.validator,
      required this.hintText,
      required this.labelText,
      required this.minLines,
      required this.maxLines,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[350]!),
        ),
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}
