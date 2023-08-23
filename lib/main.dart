import 'package:flutter/material.dart';
import 'package:student_data_using_getx/view/home/screen_home.dart';

void main() {
  runApp(const StudentDBGetX());
}

class StudentDBGetX extends StatelessWidget {
  const StudentDBGetX({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'studentDB',
      debugShowCheckedModeBanner: false,
      home: ScreenHome(),
    );
  }
}
