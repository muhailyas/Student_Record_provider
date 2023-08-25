import 'package:flutter/material.dart';
import 'package:student_data_using_getx/controllers/validation_functions/validation.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import '../../../core/constants/contants.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.function});
  final String hintText;
  final TextEditingController controller;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return '$hintText is required';
          } else if (!validateFunctions(function, value)) {
            return 'enter valid $hintText';
          }
          return null;
        },
        keyboardType: function == isValidAge ||
                function == isValidMobileNumber ||
                function == isValidBatch
            ? TextInputType.number
            : null,
        style: const TextStyle(color: kFontColorWhite),
        decoration: InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderRadius: kBorderRadius20,
                borderSide: const BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: kBorderRadius20,
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: kBorderRadius20)),
      ),
    );
  }
}
