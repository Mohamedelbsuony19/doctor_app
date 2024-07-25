import 'package:clinc_vandor/presentation/view/change_password.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_text_filed.dart';
import 'data_save_botton.dart';

class EditProfileScreenBody extends StatefulWidget {
  final UserValue getMeEntity;

  const EditProfileScreenBody({super.key, required this.getMeEntity});

  @override
  State<EditProfileScreenBody> createState() => _EditProfileScreenBodyState();
}

class _EditProfileScreenBodyState extends State<EditProfileScreenBody> {
  DateTime selectedDate = DateTime.now();
  void pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  String gender = "Male";
  @override
  void initState() {
    emailController = TextEditingController(text: widget.getMeEntity.email);
    firstNameController =
        TextEditingController(text: widget.getMeEntity.firstName);
    lastNameController =
        TextEditingController(text: widget.getMeEntity.lastName);
    phoneNumberController =
        TextEditingController(text: widget.getMeEntity.phoneNumber);

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: BlocConsumer<DoctorProfileBloc, DoctorProfileState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              success: (value) {
                if (value.isUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      content: const Text("profile Updated Successfully",
                          style: TextStyle(color: Colors.white))));
                }
              },
              failed: (value) {
                context.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(value.message)));
              },
            );
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Enter Your Email',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: firstNameController,
                    hintText: 'Enter Your First Name',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: lastNameController,
                    hintText: 'Enter Your Last Name',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    hintText: 'Enter Your Phone Number',
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(),
                      ));
                    },
                    child: const Text(
                      'change password',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  DataSaveButton(
                    onPressed: () {
                      context
                          .read<DoctorProfileBloc>()
                          .add(DoctorProfileEvent.updateDoctorProfileData(
                            email: emailController.text,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            phoneNumber: phoneNumberController.text,
                            gender: gender,
                          ));
                      Future.delayed(const Duration(seconds: 1), () {
                        context.read<GetMeBloc>().add(const GetMeEvent.getMe());
                        context.pop(context);
                        context.pop(context);
                      });
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
