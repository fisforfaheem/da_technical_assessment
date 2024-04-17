import 'package:da_technical_assessment/core/di/injection_container.dart';
import 'package:da_technical_assessment/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:da_technical_assessment/feature/auth/presentation/screen/login_screen.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_cubit.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/screen/add_beneficiary.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/screen/recharge_screen.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/screen/top_up_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // all the route paths. So that we can access them easily  across the app
  static const root = '/';
  static const homeScreen = '/homeScreen';
  static const topUpScreen = '/topUpScreen';
  static const rechargeScreen = '/rechargeScreen';
  static String addBeneficiary = "/addBeneficiary";

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  // ========================================================     NAVIGATOR HELPERS

  // push
  static Future<void> push(String path,
      {dynamic extra, BuildContext? context}) async {
    await GoRouter.of(context ?? _rootNavigatorKey.currentContext!).push(
      path,
      extra: extra,
    );
  }

  // until
  static Future<void> pushUntil(String path, {dynamic extra}) async {
    GoRouter.of(_rootNavigatorKey.currentContext!).pushReplacement(
      path,
      extra: extra,
    );
  }

  //  pop
  static void pop() {
    GoRouter.of(_rootNavigatorKey.currentContext!).pop();
  }

  // context

  // ========================================================     GETTERS

  static BuildContext get context => _rootNavigatorKey.currentContext!;

  static GoRouter get router => _router;

  //get root navigator key
  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  // ======================================================== ROUTES

  /// use this in [MaterialApp.router]
  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      /// ==========================================  ROLE BASED PAGES  ========================================
      // root

      GoRoute(
        path: root,
        builder: (context, state) {
          return BlocProvider(
            create: (ctx) => sl<LoginCubit>(),
            child: const LoginScreen(),
          );
        },
      ),

      GoRoute(
        path: topUpScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (ctx) => sl<TopUpCubit>(),
            child: const TopUpScreen(),
          );
        },
      ),

      GoRoute(
        path: addBeneficiary,
        builder: (context, state) {
          final cubit = state.extra as TopUpCubit;
          return BlocProvider.value(
            value: cubit,
            child: const AddBeneficiaryScreen(),
          );
        },
      ),

      GoRoute(
        path: rechargeScreen,
        builder: (context, state) {
          final list = state.extra as List;
          final cubit = list.first as TopUpCubit;
          final beneficiary = list.last;
          return BlocProvider.value(
            value: cubit,
            child: RechargeScreen(beneficiary: beneficiary),
          );
        },
      ),
    ],
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
  );

  /// returns the current route location
  static String currentLocation() {
    final RouteMatch lastMatch =
        GoRouter.of(context).routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : GoRouter.of(context).routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      Container();
}
