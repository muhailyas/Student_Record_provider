import 'package:flutter/material.dart';
import 'package:student_data_using_getx/controllers/db/functions/db_functions.dart';
import 'package:student_data_using_getx/models/student_model.dart';

class StudentViewController extends ChangeNotifier {
  final DB _db = DB();
  List<StudentModel> studentList = [];

  String image = '';
  void setImage(String imagePath) {
    image = imagePath;
    notifyListeners();
  }

  getStudents() async {
    studentList = await _db.getStudents();
    notifyListeners();
  }

  getSearchResult(String query) async {
    List<StudentModel> list = await _db.getStudents();
    studentList = list
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  addStudent(StudentModel student) async {
    await _db.addStudent(student);
    await getStudents();
  }

  updateStudent(StudentModel student, int id) async {
    await _db.updateStudent(student, id);
    await getStudents();
  }

  deleteStudent(int id) async {
    await _db.deleteStudent(id);
    await getStudents();
  }
}
