import 'package:clinic_package/clinic_package.dart';

void registerQueries() {
  getIt.registerSingleton<LoginQuery>(LoginQueryImpl(
    authRepo: getIt(),
  ));
  getIt.registerSingleton<ChangePasswordQuery>(ChangePasswordQueryImpl(
    authRepo: getIt(),
  ));
  getIt.registerSingleton<GetMeQuery>(
    GetMeQueryImpl(
      repo: getIt(),
    ),
  );
  getIt.registerSingleton<GetUserDataQuery>(
      GetUserDataQueryImpl(doctorRepository: getIt()));

  getIt.registerSingleton<AddScheduleQuery>(
      AddScheduleQueryImpl(scheduleRepo: getIt()));
  getIt.registerSingleton<GetAllScheduleByDotorIdQuery>(
      GetAllScheduleByDotorIdQueryImpl(scheduleRepo: getIt()));
  getIt.registerSingleton<GetTimeSlotsQuery>(
      GetTimeSlotsQueryImpl(timeSlotRepo: getIt()));

  getIt.registerSingleton<GetMedicalHistoryQuery>(
      GetMedicalHistoryQueryImpl(medicalHistoryRepo: getIt()));

  getIt.registerSingleton<GetAllAppointmentQuery>(
      GetAllAppointmentQueryImpl(appointmentRepo: getIt()));

  getIt.registerSingleton<RegisterQuery>(RegisterQueryImpl(authRepo: getIt()));

  getIt.registerSingleton<GetDoctorScheduleQuery>(
      GetDoctorSchedulesQueryImpl(repo: getIt()));

  getIt.registerSingleton<GetSchedulesByDayQuery>(
      GetSchedulesByDayQueryImpl(scheduleRepo: getIt()));

  getIt.registerSingleton<GetAppointmentForDoctorQuery>(
      GetAppointmentForDoctorQueryImpl(appointmentRepo: getIt()));

  getIt.registerSingleton<GetPrescription>(
      GetPrescriptionQueryImpl(prescriptionRepo: getIt()));

  getIt.registerSingleton<GetPayrollAllMonthsContract>(
      GetPayrollAllMonthsQueryImpl(payrollRepo: getIt()));
  getIt.registerSingleton<GetAllLeaveRequestForDoctorQuery>(
      GetLeaveRequestForDoctorQueryImpl(repo: getIt()));
}
