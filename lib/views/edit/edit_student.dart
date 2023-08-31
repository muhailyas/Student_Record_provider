// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data_using_getx/providers/providers.dart';
import '../../controllers/image_picker/image_picker.dart';
import '../../controllers/validation_functions/validation.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/contants.dart';
import '../../models/student_model.dart';
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

  initializingValues() {
    nameController.text = student.name;
    ageController.text = student.age;
    batchController.text = student.batch;
    mobileController.text = student.mobile;
    emailController.text = student.email;
  }

  @override
  Widget build(BuildContext context) {
    initializingValues();
    final studentListController =
        Provider.of<StudentViewController>(context, listen: false);
    studentListController.image = student.image;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          studentListController.image = '';
          return true;
        },
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
                        fontWeight: FontWeight.bold,
                        color: kFontColorWhite),
                  ),
                  kSizedBox10,
                  Consumer<StudentViewController>(builder: (context, value, _) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: value.image.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(File(value.image)),
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
                                  backgroundColor: MaterialStatePropertyAll(
                                      kThemeColorGreen),
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(210, 50),
                                  )),
                              onPressed: () async {
                                if (await validateForms(
                                    context: context,
                                    name: nameController.text,
                                    age: ageController.text,
                                    batch: batchController.text,
                                    mobile: mobileController.text,
                                    email: emailController.text,
                                    image: studentListController.image,
                                    formKey: formKey,
                                    isUpdate: true,
                                    id: student.id,
                                    message: 'Updated Successfully')) {
                                  studentListController.getStudents();
                                  Navigator.pop(context);
                                }
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
                                  backgroundColor: MaterialStatePropertyAll(
                                      kThemeColorGreen),
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(210, 50),
                                  )),
                              onPressed: () async {
                                image = await imagePicker();
                                if (image != null) {
                                  studentListController.setImage(image!.path);
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
      ),
    );
  }
}
