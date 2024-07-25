import 'dart:developer';

import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';

import 'clinic_doctor_app.dart';
import 'core/dependency_injection/di_container.dart';

const String baseUrl = "http://192.168.1.66:5252/api";
// const String baseUrl = "http://192.168.1.124:5000/api";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AppConfig>(
    AppConfig(
      restBaseUrl: baseUrl,
      graphQLBaseUrl: "$baseUrl/graphql",
      assetsBaseUrl: "$baseUrl/assets",
      appName: "clinicApp",
      flavorName: "dev",
    ),
  );
  await initDependencyInjection();
  log("${preferences.getString('token')}");
  log("${preferences.getString('userId')}");
  runApp(const ClinicDoctorApp());
}
