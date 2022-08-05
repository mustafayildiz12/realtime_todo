import 'package:flutter/material.dart';

class FormfieldArea extends StatelessWidget {
  const FormfieldArea(
      {required this.controller,
      this.textInputType,
      this.obscureText,
      this.hintText,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? hintText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText ?? false,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
  }
}
