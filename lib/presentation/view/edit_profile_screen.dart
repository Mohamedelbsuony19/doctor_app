import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/edit_profile_screen_body.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    // context
    //     .read<DoctorProfileBloc>()
    //     .add(const DoctorProfileEvent.getUserData());
    context.read<GetMeBloc>().add(const GetMeEvent.getMe());
  }

  @override
  Widget build(BuildContext context) {
    final meData = context
        .read<GetMeBloc>()
        .state
        .maybeMap(orElse: () {}, success: (value) => value.meEntity);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: EditProfileScreenBody(
        getMeEntity: UserValue(
          email: meData?.value?.email,
          firstName: meData?.value?.firstName,
          lastName: meData?.value?.lastName,
          phoneNumber: meData?.value?.phoneNumber,
          userName: meData?.value?.userName,
        ),
      ),
    );
  }
}
