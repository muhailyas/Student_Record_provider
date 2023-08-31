// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data_using_getx/providers/providers.dart';
import '../../core/colors/colors.dart';
import '../../models/student_model.dart';
import '../../views/register/screen_register.dart';

bool isValidName(String input) {
  return input.isNotEmpty;
}

bool isValidAge(String input) {
  try {
    int age = int.parse(input);
    if (age > 0 && age <= 120) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

bool isValidBatch(String input) {
  try {
    int batch = int.parse(input);
    if (batch >= 0 && batch <= 120) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

bool isValidMobileNumber(String input) {
  try {
    int.parse(input);
    return input.length == 10 ? true : false;
  } catch (e) {
    return false;
  }
}

bool isValidEmail(String input) {
  return input.contains('@gmail.com');
}

validateFunctions(Function function, String input) {
  if (function == isValidName) {
    return isValidName(input.trim());
  } else if (function == isValidAge) {
    return isValidAge(input);
  } else if (function == isValidBatch) {
    return isValidBatch(input);
  } else if (function == isValidMobileNumber) {
    return isValidMobileNumber(input);
  } else {
    return isValidEmail(input);
  }
}

Future<bool> validateForms({
  required BuildContext context,
  required String name,
  required String age,
  required String batch,
  required String mobile,
  required String email,
  required String image,
  required GlobalKey<FormState> formKey,
  required bool isUpdate,
  required String message,
  int? id,
}) async {
  if (!formKey.currentState!.validate()) {
    return false;
  } else if (imageNotifier.value.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          backgroundColor: kThemeColorGreen,
          content: Text('Image is required')),
    );
    return false;
  }
  final student = StudentModel(
      name: name,
      age: age,
      batch: batch,
      mobile: mobile,
      email: email,
      image: image);
  if (isUpdate) {
    await context.read<StudentViewController>().updateStudent(student, id!);
  } else {
    await context.read<StudentViewController>().addStudent(student);
  }
  formKey.currentState!.reset();
  imageNotifier.value = '';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: kThemeColorGreen, content: Text(message)),
  );
  return true;
}
