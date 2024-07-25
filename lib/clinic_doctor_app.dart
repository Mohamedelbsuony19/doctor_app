import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/app_router.dart';

class ClinicDoctorApp extends StatelessWidget {
  const ClinicDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme customTextTheme = createTextTheme(context, 'Roboto', 'Roboto');
    MaterialTheme materialTheme = MaterialTheme(customTextTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DoctorProfileBloc(
            getUserDataQuery: getIt(),
            updateDoctorProfileQuery: getIt(),
          )..add(const DoctorProfileEvent.getUserData()),
        ),
        BlocProvider(
            create: (context) => AuthBloc(
                  registerQuery: getIt(),
                  changePasswordQuery: getIt(),
                  loginQuery: getIt(),
                )),
        BlocProvider(
          create: (context) => ScheduleBloc(
            getSchedulesByDoctorId: getIt(),
            getSchedulesByDoctorIdDay: getIt(),
            getAllScheduleQuery: getIt(),
            addScheduleQuery: getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => TimeSlotBloc(
            getTimeSlotsQuery: getIt(),
          )..add(const TimeSlotEvent.getAllTimeSlots()),
        ),
        BlocProvider(
          create: (context) => MedicalHistoryBloc(
            getMedicalHistoryQuery: getIt(),
            addMedicalHistoryCommand: getIt(),
            updateMedicalHistoryCommand: getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => PrescriptionBloc(
            getIt(),
            getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => LeaveRequestBloc(
            getIt(),
            getIt(),
            getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => AttendanceBloc(
            getIt(),
            getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => AttendanceBloc(
            getIt(),
            getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => GetMeBloc(getIt()),
        ),
        BlocProvider(
            create: (context) => AppointmentBloc(
                  getAppointmentForDoctorQuery: getIt(),
                  changeStatusAppointmentCommand: getIt(),
                  addAppointmentCommand: getIt(),
                  deleteAppointmentCommand: getIt(),
                  getAppointmentQuery: getIt(),
                )..add(const AppointmentEvent.getAppointmentsForDoctor())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: allRoutes,
        theme: materialTheme.light(), 
        darkTheme: materialTheme.dark(),
      ),
    );
  }
}
