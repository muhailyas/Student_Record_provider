import 'package:flutter/material.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import '../../core/constants/contants.dart';

class ScreenRegister extends StatelessWidget {
  const ScreenRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kThemeColorGreen,
        body: SingleChildScrollView(
          child: Column(
            children: [
              kWidthDoubleInfinity,
              kSizedBox30,
              const Text(
                "Registeration",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              kSizedBox10,
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
              kSizedBox20,
              const TextFormFieldWidget(hintText: 'Name'),
              const TextFormFieldWidget(hintText: 'Age'),
              const TextFormFieldWidget(hintText: 'Batch'),
              const TextFormFieldWidget(hintText: 'Mobile'),
              const TextFormFieldWidget(hintText: 'Location'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(kFontColorWhite),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            fixedSize: MaterialStatePropertyAll(
                              Size(210, 50),
                            )),
                        onPressed: () {},
                        icon: const Icon(Icons.save),
                        label: const Text("Save")),
                    TextButton.icon(
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(kFontColorWhite),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            fixedSize: MaterialStatePropertyAll(
                              Size(210, 50),
                            )),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cloud_upload,
                        ),
                        label: const Text("Upload Image")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({super.key, required this.hintText});
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return '$hintText is required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderRadius: kBorderRadius20,
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: kBorderRadius20)),
      ),
    );
  }
}
