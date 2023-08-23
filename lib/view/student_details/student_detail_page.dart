import 'package:flutter/material.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import 'package:student_data_using_getx/core/constants/contants.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kThemeColorGreen,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            kWidthDoubleInfinity,
            kSizedBox30,
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
            kSizedBox20,
            const SizedBox(
              width: 180,
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Name:ilyas",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  kSizedBox10,
                  Text(
                    "Age:19",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  kSizedBox10,
                  Text(
                    "Batch:98",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  kSizedBox10,
                  Text(
                    "Mobile:8089080606",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  kSizedBox10,
                  Text(
                    "Location:Kochi",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
