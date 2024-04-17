import 'package:da_technical_assessment/core/app_theme/app_theme.dart';
import 'package:da_technical_assessment/core/color/app_colors.dart';
import 'package:da_technical_assessment/core/router/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Craft',
      routerConfig: AppRouter.router,
      theme: AppTheme.theme,
    );
  }
}
