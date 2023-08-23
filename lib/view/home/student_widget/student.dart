import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';

class Student extends StatelessWidget {
  const Student({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: kThemeColorGreen,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 40,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.135,
                width: MediaQuery.of(context).size.height * 0.135,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.amber),
              ),
            ),
            const Positioned(
              bottom: 10,
              left: 43,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: Center(
                        child: Text(
                      "Ilyas",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: kFontColorWhite),
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                  Text(
                    "Batch:98",
                    style: TextStyle(fontSize: 15, color: kFontColorWhite),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert_outlined,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
