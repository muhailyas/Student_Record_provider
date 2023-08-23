import 'package:flutter/material.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import 'package:student_data_using_getx/view/home/student_widget/student.dart';
import 'package:student_data_using_getx/view/register/screen_register.dart';
import '../student_details/student_detail_page.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: kThemeColorGreen,
          title: const Text(
            'CodeVault Edu',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StudentDetails(),
                            ));
                      },
                      child: const Student()),
                ),
              ),
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
                    builder: (context) => const ScreenRegister(),
                  ));
            }),
      ),
    );
  }
}
