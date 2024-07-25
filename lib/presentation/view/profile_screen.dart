import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/routes.dart';
import '../widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<GetMeBloc>().add(const GetMeEvent.getMe());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade400,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Text(
              "${preferences.getString(SharedKeys.userName)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            ProfileItem(
              onTap: () {
                context.push(Routes.editProfile);
              },
              text: 'Edit Profile',
              icon: Icons.edit,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            ProfileItem(
              onTap: () {
                context.push(Routes.checkInCheckOutScreen);
              },
              text: 'Check In/Check Out',
              icon: Icons.calendar_month,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            ProfileItem(
              onTap: () => context.push(Routes.payrollScreen),
              text: 'Payroll',
              icon: Icons.monetization_on_outlined,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            ProfileItem(
                onTap: () => context.push(Routes.leaveRequest),
                text: 'Leave Requests',
                icon: Icons.legend_toggle),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            ProfileItem(
              onTap: () async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'Logout',
                  desc: 'Are you sure you want to logout?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    await preferences.clear();
                    if (context.mounted) {
                      context.go(Routes.login);
                    }
                  },
                ).show();
              },
              text: 'Logout',
              icon: Icons.logout,
            ),
          ],
        ),
      )),
    );
  }
}
