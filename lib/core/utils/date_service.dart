import 'utils.dart';

class DateTimeService {
  static DateTime userCurrentMonth = DateTime.now();

  static bool isUserDateWithInTheMonth() {
    // Get the current date
    DateTime now = DateTime.now();
    // Get the last day of the current month
    return Utils.getUserLoggedInDate().month == now.month;
  }
}
