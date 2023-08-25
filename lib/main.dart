import 'package:flutter/material.dart';
import 'package:student_data_using_getx/controllers/db/functions/db_functions.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import 'package:student_data_using_getx/view/home/screen_home.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = DB.instance;
  await db.initialiseDatabase();
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
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
    );
  }
}
