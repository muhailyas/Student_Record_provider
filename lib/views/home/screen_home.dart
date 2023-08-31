import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import 'package:student_data_using_getx/providers/providers.dart';
import 'package:student_data_using_getx/providers/search_provider.dart';
import 'package:student_data_using_getx/views/home/widgets/student_widget/student.dart';
import 'package:student_data_using_getx/views/register/screen_register.dart';
import '../student_details/student_detail_page.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  @override
  Widget build(BuildContext context) {
    final studentListController =
        Provider.of<StudentViewController>(context, listen: false);
    studentListController.getStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: kThemeColorGreen,
          title: Consumer<SearchProvider>(
            builder: (context, value, child) => value.isSearching
                ? TextField(
                    autofocus: true,
                    style: const TextStyle(color: kFontColorWhite),
                    onChanged: (value) {
                      studentListController.getSearchResult(value);
                    },
                    decoration: const InputDecoration(
                        hintText: 'search',
                        hintStyle: TextStyle(color: kFontColorWhite),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kFontColorWhite)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kFontColorWhite))),
                  )
                : const Text(
                    "CODEVAULT EDU",
                    style: TextStyle(
                        fontSize: 35,
                        letterSpacing: -1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
          ),
          actions: [
            Consumer<SearchProvider>(builder: (context, value, _) {
              return IconButton(
                onPressed: () {
                  value.searchToggle();
                  if (!value.isSearching) {
                    studentListController.getStudents();
                  }
                },
                icon: value.isSearching
                    ? const Icon(Icons.clear)
                    : const Icon(Icons.search),
              );
            }),
          ],
        ),
        body: Consumer<SearchProvider>(
          builder: (context, searchValue, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:
                  Consumer<StudentViewController>(builder: (context, value, _) {
                if (value.studentList.isEmpty && searchValue.isSearching) {
                  return const Center(
                    child: Text(
                      "No data found",
                      style: TextStyle(color: kFontColorWhite),
                    ),
                  );
                } else if (value.studentList.isEmpty) {
                  return const Center(
                    child: Text(
                      "No data added yet",
                      style: TextStyle(color: kFontColorWhite),
                    ),
                  );
                }
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.studentList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentDetails(
                                  student: value.studentList[index]),
                            ));
                      },
                      child: Student(
                        student: value.studentList[index],
                      )),
                );
              }),
            );
          },
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
