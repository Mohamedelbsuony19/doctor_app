abstract class Routes {
  static const String reschedule = '/reschedule';

  static const String login = '/login';
  static const String layout = '/';

  static const String editProfile = '/editProfile';
  static const String leaveRequest = '/leaveRequest';
  static const String checkInCheckOutScreen = '/checkInCheckOutScreen';
  static const String payrollScreen= '/payrollScreen';
}

extension RemoveSlash on String {
  String get removeSlash {
    try {
      if (startsWith("/")) {
        return substring(1);
      } else {
        return this;
      }
    } catch (e) {
      return this;
    }
  }
}

extension AddSlash on String {
  String get withSlash {
    try {
      if (startsWith("/")) {
        return this;
      } else {
        return "/$this";
      }
    } catch (e) {
      return this;
    }
  }
}
