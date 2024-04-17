import 'package:da_technical_assessment/app_main/my_app.dart';
import 'package:da_technical_assessment/core/config/app_config.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.init();
  runApp(const MyApp());
}

