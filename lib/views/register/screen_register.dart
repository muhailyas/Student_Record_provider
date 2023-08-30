import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_data_using_getx/controllers/validation_functions/validation.dart';
import 'package:student_data_using_getx/core/colors/colors.dart';
import 'package:student_data_using_getx/providers/providers.dart';
import '../../controllers/image_picker/image_picker.dart';
import '../../core/constants/contants.dart';
import '../widgets/text_fom_field_widget/text_form_field_widget.dart';

XFile? image;
ValueNotifier<String> imageNotifier = ValueNotifier('');

class ScreenRegister extends StatelessWidget {
  ScreenRegister({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final studentListController =
        Provider.of<StudentViewController>(context, listen: false);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          imageNotifier.value = '';
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
                    "Registeration",
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
                            color: kThemeColorGreen,
                            image: imageNotifier.value.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(File(value)),
                                    fit: BoxFit.cover)
                                : null,
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
                                    isUpdate: false,
                                    context: context,
                                    name: nameController.text,
                                    age: ageController.text,
                                    batch: batchController.text,
                                    mobile: mobileController.text,
                                    email: emailController.text,
                                    image: imageNotifier.value,
                                    formKey: formKey,
                                    message: 'Student added Successfully')) {
                                  studentListController.getStudents();
                                }
                              },
                              icon: const Icon(Icons.save),
                              label: const Text("Save")),
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
      ),
    );
  }
}
