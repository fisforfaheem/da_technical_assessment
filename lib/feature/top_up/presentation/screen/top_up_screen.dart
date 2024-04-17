import 'package:da_technical_assessment/core/app_strings/app_strings.dart';
import 'package:da_technical_assessment/core/color/app_colors.dart';
import 'package:da_technical_assessment/core/router/routes.dart';
import 'package:da_technical_assessment/core/utils/utils.dart';
import 'package:da_technical_assessment/core/widgets/common_elevated_button.dart';
import 'package:da_technical_assessment/core/widgets/gap.dart';
import 'package:da_technical_assessment/feature/auth/data/models/user_model.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_cubit.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_state.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/screen/history/top_up_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/top_up_list_body_card.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TopUpCubit>();
    return Scaffold(
      floatingActionButton: BlocBuilder<TopUpCubit, TopUpState>(
        builder: (ctx, state) {
          return state.tabName != AppStrings.recharge
              ? const SizedBox.shrink()
              : CommonElevatedButton(
                  onPressed: cubit.beneficiaries.length >= 5
                      ? null
                      : () {
                          AppRouter.push(AppRouter.addBeneficiary,
                              extra: cubit);
                        },
                  tooltip: cubit.beneficiaries.length >= 5
                      ? 'already added 5 beneficiaries'
                      : '',
                  title: AppStrings.addBeneficiary,
                );
        },
      ),
      appBar: AppBar(
        title: const Text(AppStrings.mobileRecharge),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Utils.currentUser.isVerified == true
                  ? Icons.verified_user_sharp
                  : Icons.verified_user_outlined,
              size: 20,
            ),
          ),
        ],
      ),
      body: BlocBuilder<TopUpCubit, TopUpState>(
        builder: (ctx, state) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                // tab header
                Container(
                  height: 40,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [AppStrings.recharge, AppStrings.history].map(
                      (e) {
                        return Expanded(
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => cubit.toggleTab(e),
                            child: Container(
                              height: 35,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color:
                                    e == state.tabName ? AppColors.white : null,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Text(
                                  e,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: e == state.tabName
                                        ? AppColors.primaryColor
                                        : AppColors.black,
                                    fontWeight: e == state.tabName
                                        ? FontWeight.w500
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const Gap(value: 20),

                state.tabName == AppStrings.recharge
                    ?

                    // beneficiaries List
                    cubit.beneficiaries.isEmpty
                        ? const Text(AppStrings.noBeneficiaries)
                        : SizedBox(
                            height: 130,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.beneficiaries.length,
                              itemBuilder: (ctx, index) {
                                final TopUpEntity? beneficiary =
                                    cubit.beneficiaries.elementAtOrNull(index);

                                if (beneficiary == null) {
                                  return const SizedBox.shrink();
                                }

                                return TopUpListBodyCard(
                                  beneficiary: beneficiary,
                                );
                              },
                            ),
                          )
                    : const TopUpHistoryWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
