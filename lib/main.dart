import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data_using_getx/controllers/db/functions/db_functions.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import 'package:student_data_using_getx/providers/providers.dart';
import 'package:student_data_using_getx/providers/search_provider.dart';
import 'package:student_data_using_getx/test/test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_using_getx/views/home/screen_home.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterController>(
          create: (context) => CounterController(),
        ),
        ChangeNotifierProvider<StudentViewController>(
          create: (context) => StudentViewController(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        )
      ],
      child: MaterialApp(
        title: 'studentDB',
        debugShowCheckedModeBanner: false,
        home: ScreenHome(),
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
      ),
    );
  }
}
