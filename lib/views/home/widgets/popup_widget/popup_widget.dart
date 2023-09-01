// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import 'package:student_data_using_getx/models/student_model.dart';
import 'package:student_data_using_getx/providers/providers.dart';
import 'package:student_data_using_getx/views/edit/edit_student.dart';

class Popupwidget extends StatelessWidget {
  const Popupwidget({super.key, required this.student});
  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: kThemeColorGreen,
      elevation: 10,
      icon: const Icon(
        Icons.more_vert_outlined,
        color: Colors.white,
      ),
      onSelected: (value) async {
        if (value == 'edit') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScreenEditStduent(student: student),
          ));
        } else if (value == 'delete') {
          context.read<StudentViewController>().deleteStudent(student.id!);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Deleted Successfully')));
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'edit',
            child: ListTile(
              leading: Icon(
                Icons.edit,
                color: kThemeWhite,
              ),
              title: Text(
                'Edit',
                style: TextStyle(color: kThemeWhite),
              ),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: ListTile(
              leading: Icon(
                Icons.delete,
                color: kThemeWhite,
              ),
              title: Text(
                'delete',
                style: TextStyle(color: kThemeWhite),
              ),
            ),
          ),
        ];
      },
    );
  }
}
