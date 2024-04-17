import 'package:da_technical_assessment/core/app_strings/app_strings.dart';
import 'package:da_technical_assessment/core/color/app_colors.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpHistoryWidget extends StatelessWidget {
  const TopUpHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TopUpCubit>();
    return cubit.history.isEmpty
        ? Text(AppStrings.noHistory)
        : Expanded(
            child: ListView.builder(
              itemCount: cubit.beneficiaries.length,
              itemBuilder: (ctx, index) {
                final TopUpEntity? beneficiary =
                    cubit.history.elementAtOrNull(index);

                if (beneficiary == null) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    tileColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.grey.withOpacity(.1)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      beneficiary.nickname.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      beneficiary.phoneNumber.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: Text('${beneficiary.amount} AED'),
                  ),
                );
              },
            ),
          );
  }
}
