import 'package:clinic_package/clinic_package.dart';


void registerRepositories() {
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      authDataSource: getIt(),
    ),
  );
  getIt
      .registerSingleton<DoctorRepo>(DoctorRepoImpl(doctorDataSource: getIt()));
  getIt.registerSingleton<MeRepo>(GetMeRepoImpl(getMeDataSource: getIt()));
  getIt.registerSingleton<PrescriptionRepo>(
      PrescriptionRepoImpl(prescriptionDataSource: getIt()));
  getIt.registerSingleton<ScheduleRepo>(
      ScheduleRepoImpl(scheduleDataSource: getIt()));
  getIt.registerSingleton<TimeSlotRepo>(
      TimeSlotRepoImpl(timeSlotDataSource: getIt()));

  getIt.registerSingleton<MedicalHistoryRepo>(
      MedicalHistoryRepoImpl(medicalHistoryDataSource: getIt()));

  getIt.registerSingleton<AppointmentRepo>(
      AppointmentRepoImpl(appointmentDataSource: getIt()));
  getIt.registerSingleton<AttendanceRepo>(
      AttendanceRepoImpl(attendanceDataSource: getIt()));
  

  getIt.registerSingleton<PayrollRepo>(
      PayrollRepoImpl(payrollDataSource: getIt()));
  getIt.registerSingleton<LeaveRequestRepo>(
      LeaveRequestRepoImpl( leaveRequestDataSource: getIt()));
}
