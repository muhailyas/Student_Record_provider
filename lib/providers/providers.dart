import 'package:flutter/material.dart';
import 'package:student_data_using_getx/controllers/db/functions/db_functions.dart';
import 'package:student_data_using_getx/models/student_model.dart';

class StudentViewController extends ChangeNotifier {
  List<StudentModel> studentList = [];
  getStudents() async {
    studentList = await DB.instance.getStudents();
    notifyListeners();
  }

  getSearchResult(String query) async {
    List<StudentModel> list = await DB.instance.getStudents();
    studentList = list
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
