import 'package:clinic_package/clinic_package.dart';

void registerDataSources() {
  getIt.registerSingleton<GetMeDataSource>(
    GetMeDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<AuthDataSource>(
    AuthDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<PrescriptionDataSource>(
    PrescriptionDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<DoctorDataSource>(
    DoctorDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<ScheduleDataSource>(
    ScheduleDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<TimeSlotDataSource>(
      TimeSlotDataSourceImpl(baseDio: getIt()));

  getIt.registerSingleton<MedicalHistoryDataSource>(
      MedicalHistoryDataSourceImpl(baseDio: getIt()));

  getIt.registerSingleton<AppointmentDataSource>(
      AppointmentDataSourceImpl(dioClient: getIt()));

  getIt.registerSingleton<AttendanceDataSource>(
      AttendanceDataSourceImpl(baseDio: getIt()));
  getIt.registerSingleton<PayrollDataSource>(
      PayrollDataSourceImpl(baseDio: getIt()));
  getIt.registerSingleton<LeaveRequestDataSource>(
      LeaveRequestDataSourceImpl(dioClient: getIt()));
}
