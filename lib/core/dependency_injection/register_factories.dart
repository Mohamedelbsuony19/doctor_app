import 'package:clinic_package/clinic_package.dart';

void registerFactories() {
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      registerQuery: getIt(),
      loginQuery: getIt(),
      changePasswordQuery: getIt(),
    ),
  );
  getIt.registerFactory<DoctorProfileBloc>(
    () => DoctorProfileBloc(
      getUserDataQuery: getIt(),
      updateDoctorProfileQuery: getIt(),
    ),
  );
  getIt.registerFactory<GetMeBloc>(() => GetMeBloc(getIt()));

  getIt.registerFactory<ScheduleBloc>(() => ScheduleBloc(
        getSchedulesByDoctorId: getIt(),
        addScheduleQuery: getIt(),
        getAllScheduleQuery: getIt(),
        getSchedulesByDoctorIdDay: getIt(),
      ));
  getIt.registerFactory<TimeSlotBloc>(
      () => TimeSlotBloc(getTimeSlotsQuery: getIt()));

  getIt.registerFactory<MedicalHistoryBloc>(() => MedicalHistoryBloc(
      getMedicalHistoryQuery: getIt(),
      addMedicalHistoryCommand: getIt(),
      updateMedicalHistoryCommand: getIt()));
  getIt.registerFactory<PrescriptionBloc>(() => PrescriptionBloc(
        getIt(),
        getIt(),
      ));
  getIt.registerFactory<AttendanceBloc>(
      () => AttendanceBloc( 
      getIt(),
      getIt(),
      ));
  getIt.registerFactory<LeaveRequestBloc>(
      () => LeaveRequestBloc( 
      getIt(),
      getIt(),
      getIt(),
      ));

  getIt.registerFactory<AppointmentBloc>(() => AppointmentBloc(
        getAppointmentQuery: getIt(),
        addAppointmentCommand: getIt(),
        changeStatusAppointmentCommand: getIt(),
        deleteAppointmentCommand: getIt(),
        getAppointmentForDoctorQuery: getIt(),
      ));
  getIt.registerFactory<PayrollBloc>(() => PayrollBloc(getIt()));
}
