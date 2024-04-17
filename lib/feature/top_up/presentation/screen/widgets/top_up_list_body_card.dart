import 'package:da_technical_assessment/core/app_strings/app_strings.dart';
import 'package:da_technical_assessment/core/color/app_colors.dart';
import 'package:da_technical_assessment/core/router/routes.dart';
import 'package:da_technical_assessment/core/widgets/common_elevated_button.dart';
import 'package:da_technical_assessment/core/widgets/gap.dart';
import 'package:da_technical_assessment/feature/auth/data/models/user_model.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpListBodyCard extends StatelessWidget {
  const TopUpListBodyCard({
    super.key,
    required this.beneficiary,
  });

  final TopUpEntity beneficiary;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(
          //     onPressed: () {
          //       context.read<TopUpCubit>().deleteBeneficiary(beneficiary);
          //     },
          //     icon: const Icon(Icons.close),
          //   ),
          // ),
          Text(
            beneficiary.nickname.toString(),
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(value: 5),
          Text(
            beneficiary.phoneNumber.toString(),
            style: const TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(),
          InkWell(
            onTap: () {
              AppRouter.push(
                AppRouter.rechargeScreen,
                extra: [
                  context.read<TopUpCubit>(),
                  beneficiary,
                ],
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.primaryColor,
              ),
              child: const Text(
                AppStrings.rechargeNow,
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const Gap(),
        ],
      ),
    );
  }
}
