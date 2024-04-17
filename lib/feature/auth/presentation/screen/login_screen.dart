import 'package:da_technical_assessment/core/app_strings/app_strings.dart';
import 'package:da_technical_assessment/core/color/app_colors.dart';
import 'package:da_technical_assessment/core/cubit/login_state.dart';
import 'package:da_technical_assessment/core/enums/enums.dart';
import 'package:da_technical_assessment/core/router/routes.dart';
import 'package:da_technical_assessment/core/utils/utils.dart';
import 'package:da_technical_assessment/core/widgets/common_elevated_button.dart';
import 'package:da_technical_assessment/core/widgets/common_loader_widget.dart';
import 'package:da_technical_assessment/core/widgets/common_text_field_widget.dart';
import 'package:da_technical_assessment/core/widgets/gap.dart';
import 'package:da_technical_assessment/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.login,
                  style: TextStyle(
                    fontSize: 32,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(
                  value: 30,
                ),
                CommonTextFieldWidget(
                  hintText: AppStrings.username,
                  controller: usernameController,
                  validation: (txt) {
                    return txt!.isEmpty ? AppStrings.pleaseEnterText : null;
                  },
                ),
                const Gap(),
                CommonTextFieldWidget(
                  hintText: AppStrings.password,
                  controller: passwordController,
                  validation: (txt) {
                    return txt!.isEmpty ? AppStrings.pleaseEnterText : null;
                  },
                ),
                const Gap(),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (ctx, state) {
                    if (state.status == StatusEnum.failed) {
                      Utils.toast(ctx, state.message);
                    }

                    if (state.status == StatusEnum.success) {
                      AppRouter.pushUntil(AppRouter.topUpScreen);
                    }
                  },
                  builder: (ctx, state) {
                    return state.status == StatusEnum.loading
                        ? const CommonLoaderWidget()
                        : CommonElevatedButton(
                            onPressed: () {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              context.read<LoginCubit>().login(
                                    usernameController.text,
                                    passwordController.text,
                                  );
                            },
                            title: AppStrings.login,
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
