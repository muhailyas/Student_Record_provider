import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/db/functions/db_functions.dart';
import '../../controllers/validation_functions/validation.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/contants.dart';
import '../../models/student_model.dart';
import '../home/screen_home.dart';
import '../register/screen_register.dart';
import '../widgets/text_fom_field_widget/text_form_field_widget.dart';

class ScreenEditStduent extends StatelessWidget {
  ScreenEditStduent({super.key, required this.student});
  final StudentModel student;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  initializingValues() {
    nameController.text = student.name;
    ageController.text = student.age;
    batchController.text = student.batch;
    mobileController.text = student.mobile;
    emailController.text = student.email;
    imageNotifier.value = student.image;
  }

  @override
  Widget build(BuildContext context) {
    initializingValues();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                kWidthDoubleInfinity,
                kSizedBox30,
                const Text(
                  "Edit",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                kSizedBox10,
                ValueListenableBuilder(
                    valueListenable: imageNotifier,
                    builder: (context, value, _) {
                      return Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          image: imageNotifier.value.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(File(value)),
                                  fit: BoxFit.cover)
                              : const DecorationImage(
                                  image: NetworkImage(
                                      'https://media.gq.com/photos/56e853e7161e63486d04d6c8/4:3/w_1600,h_1200,c_limit/david-beckham-gq-0416-2.jpg'),
                                  fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                        child: const Align(
                            alignment: Alignment(0.8, -.7),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              size: 35,
                              color: kThemeWhite,
                            )),
                      );
                    }),
                kSizedBox20,
                TextFormFieldWidget(
                    hintText: 'Name',
                    controller: nameController,
                    function: isValidName),
                TextFormFieldWidget(
                  hintText: 'Age',
                  controller: ageController,
                  function: isValidAge,
                ),
                TextFormFieldWidget(
                  hintText: 'Batch',
                  controller: batchController,
                  function: isValidBatch,
                ),
                TextFormFieldWidget(
                  hintText: 'Mobile',
                  controller: mobileController,
                  function: isValidMobileNumber,
                ),
                TextFormFieldWidget(
                  hintText: 'Email',
                  controller: emailController,
                  function: isValidEmail,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TextButton.icon(
                            style: const ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll(kFontColorWhite),
                                backgroundColor:
                                    MaterialStatePropertyAll(kThemeColorGreen),
                                fixedSize: MaterialStatePropertyAll(
                                  Size(210, 50),
                                )),
                            onPressed: () {
                              validate(context);
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Update")),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TextButton.icon(
                            style: const ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll(kFontColorWhite),
                                backgroundColor:
                                    MaterialStatePropertyAll(kThemeColorGreen),
                                fixedSize: MaterialStatePropertyAll(
                                  Size(210, 50),
                                )),
                            onPressed: () async {
                              image = await imagePicker();
                              if (image != null) {
                                imageNotifier.value = image!.path;
                              }
                            },
                            icon: const Icon(
                              Icons.cloud_upload,
                            ),
                            label: const Text("Upload Image")),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else if (imageNotifier.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: kThemeColorGreen,
            content: Text('Image is required')),
      );
      return;
    }

    final newStudent = StudentModel(
        name: nameController.text,
        age: ageController.text,
        batch: batchController.text,
        mobile: mobileController.text,
        email: emailController.text,
        image: imageNotifier.value);
    DB db = DB.instance;
    await db.updateStudent(newStudent, student.id!);
    image = null;
    imageNotifier.value = '';
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          backgroundColor: kThemeColorGreen,
          content: Text('Updated Successfully')),
    );
    studentListNotifier.value = await DB.instance.getStudents();
  }

  Future<XFile> imagePicker() async {
    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        throw Exception("No image was selected.");
      }
      return image;
    } catch (e) {
      throw Exception(e);
    }
  }
}
