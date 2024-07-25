import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_navigation.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomNavigationBarBody(
          context: context,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            switch (index) {
              case 0:
                context
                    .read<AppointmentBloc>()
                    .add(const AppointmentEvent.getAppointmentsForDoctor());

                break;
              case 1:
                context.read<ScheduleBloc>().add( ScheduleEvent.getAll(
                  doctorId: preferences.getString( SharedKeys.userId)??"",
                ));
                break;
              default:
                break;
            }
          },
        ),
        body: screens[currentIndex]);
  }
}
