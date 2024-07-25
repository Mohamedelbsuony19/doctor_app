import 'package:clinc_vandor/presentation/view/check_in_screen.dart';
import 'package:clinc_vandor/presentation/view/leave_requests_screen.dart';
import 'package:clinc_vandor/presentation/view/payroll_screen.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/view/edit_profile_screen.dart';
import '../../presentation/view/layout_screen.dart';
import '../../presentation/view/login_screen.dart';
import 'routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final token = preferences.getString(SharedKeys.accessToken);

final GoRouter allRoutes = GoRouter(
  initialLocation: (token == null) ? Routes.login : Routes.layout,
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.leaveRequest,
      builder: (context, state) => const LeaveRequestsScreen(),
    ),
    GoRoute(
      path: Routes.editProfile,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: Routes.layout,
      builder: (context, state) => const LayoutScreen(),
    ),
    GoRoute(
      path: Routes.checkInCheckOutScreen,
      builder: (context, state) => const CheckInCheckOutScreen(),
    ),
    GoRoute(
      path: Routes.payrollScreen,
      builder: (context, state) => const PayrollScreen(),
    ),
  ],
);
