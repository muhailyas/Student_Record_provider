import 'package:flutter/material.dart';
import 'package:student_data_using_getx/controllers/db/functions/db_functions.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import 'package:student_data_using_getx/view/home/widgets/student_widget/student.dart';
import 'package:student_data_using_getx/view/register/screen_register.dart';
import '../../models/student_model.dart';
import '../student_details/student_detail_page.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final TextEditingController controller = TextEditingController();
  getStudents() async {
    studentListNotifier.value = await DB.instance.getStudents();
  }

  @override
  Widget build(BuildContext context) {
    getStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: kThemeColorGreen,
          title: const Text(
            "CODEVAULT EDU",
            style: TextStyle(
                fontSize: 35,
                letterSpacing: -1,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: studentListNotifier,
                  builder: (context, value, _) {
                    return Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: value.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StudentDetails(student: value[index]),
                                  ));
                            },
                            child: Student(
                              student: value[index],
                            )),
                      ),
                    );
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 10,
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenRegister(),
                  ));
            }),
      ),
    );
  }
}
