import 'package:da_technical_assessment/core/color/app_colors.dart';
import 'package:da_technical_assessment/core/constants.dart';
import 'package:da_technical_assessment/core/di/injection_container.dart';
import 'package:da_technical_assessment/core/router/routes.dart';
import 'package:da_technical_assessment/core/utils/date_service.dart';
import 'package:da_technical_assessment/core/utils/top_up_service.dart';
import 'package:da_technical_assessment/core/widgets/common_loader_widget.dart';
import 'package:da_technical_assessment/feature/auth/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static UserEntity currentUser = UserEntity();

  // debug print data
  static void debug(dynamic message, [StackTrace? stackTrace]) {
    debugPrint(message);
    // log(message.toString());
  }

  static void toast(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
    );
  }

  static bool isDialogShowing = false;

  static void showLoaderDialog() {
    if (isDialogShowing) return;
    showDialog<void>(
      context: AppRouter.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const CommonLoaderWidget();
      },
    );
  }

  static void hideDialog() {
    if (!isDialogShowing) return;
    Navigator.of(AppRouter.context, rootNavigator: true).pop();
  }

  static void resetUserDateTimeLoggedData() {
    // Initial configuration for the application for user
    final preferences = sl<SharedPreferences>();
    if (!DateTimeService.isUserDateWithInTheMonth()) {
      // reset the user's date' && limit

      sl<SharedPreferences>().setString(
        AppKeyConstants.userDateTime,
        DateTime.now().toIso8601String(),
      );
      TopUpService.maxBasedLimitAmount = 3000;
    }

    if (preferences.getBool(AppKeyConstants.isDateTimeLogged) == false) {
      sl<SharedPreferences>().setString(
        AppKeyConstants.userDateTime,
        DateTime.now().toIso8601String(),
      );
      sl<SharedPreferences>().setBool(AppKeyConstants.isDateTimeLogged, true);
    }
  }

  static DateTime getUserLoggedInDate() {
    final preferences = sl<SharedPreferences>();
    return DateTime.parse(
      preferences.getString(AppKeyConstants.userDateTime) ??
          DateTime.now().toIso8601String(),
    );
  }
}
