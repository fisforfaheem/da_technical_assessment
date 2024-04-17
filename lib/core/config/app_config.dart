import 'package:da_technical_assessment/core/constants.dart';
import 'package:da_technical_assessment/core/di/cache_container.dart';
import 'package:da_technical_assessment/core/di/domain_container.dart';
import 'package:da_technical_assessment/core/di/injection_container.dart';
import 'package:da_technical_assessment/core/di/remote_container.dart';
import 'package:da_technical_assessment/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static init() async {
    await initDI();

    Utils.resetUserDateTimeLoggedData();
  }
}
