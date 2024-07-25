import 'package:clinic_package/clinic_package.dart';

void registerCommands() {
  getIt.registerSingleton<DeleteAppointmentCommand>(
      DeleteAppointmentCommandImpl(appointmentRepo: getIt()));
  getIt.registerSingleton<AddPrescription>(
      AddPrescriptionCommandImpl(prescriptionRepo: getIt()));
  getIt.registerSingleton<ChangeStatusAppointmentCommand>(
      ChangeAppointmentStatusCommandImpl(appointmentRepo: getIt()));
  getIt.registerSingleton<AddAppointmentCommand>(
      AddAppointmentCommandImpl(appointmentRepo: getIt()));
  getIt.registerSingleton<UpdateDoctorProfileCommand>(
      UpdateDoctorProfileCommandImpl(doctorRepo: getIt()));
  getIt.registerSingleton<CheckInQuery>(
      CheckInQueryImpl(attendanceRepo: getIt()));
  getIt.registerSingleton<CheckOutQuery>(
      CheckOutQueryImpl(attendanceRepo: getIt()));
  getIt.registerSingleton<AddLeaveRequestQuery>(
      AddLeaveRequestCommandImpl(leaveRequestRepo: getIt()));
  getIt.registerSingleton<DeleteLeaveRequestCommand>(
      DeleteLeaveRequestCommandImpl(repo: getIt()));
}
