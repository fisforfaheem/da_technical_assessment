import 'package:da_technical_assessment/core/app_strings/app_strings.dart';
import 'package:da_technical_assessment/core/color/app_colors.dart';
import 'package:da_technical_assessment/core/enums/enums.dart';
import 'package:da_technical_assessment/core/utils/utils.dart';
import 'package:da_technical_assessment/core/widgets/common_elevated_button.dart';
import 'package:da_technical_assessment/core/widgets/common_loader_widget.dart';
import 'package:da_technical_assessment/core/widgets/common_text_field_widget.dart';
import 'package:da_technical_assessment/core/widgets/gap.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_cubit.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key, required this.beneficiary});

  final TopUpEntity beneficiary;

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  int _rechargeAmount = 0;

  final TextEditingController _amountController = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  late final TopUpCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TopUpCubit>(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.topUp),
      ),
      bottomNavigationBar: const Text(
        'Note: 1 AED will be detected as top up charges on transaction',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formState,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(),
                Text(
                  AppStrings.beneficiaryDetails,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(widget.beneficiary.nickname.toString()),
                  subtitle: Text(widget.beneficiary.phoneNumber.toString()),
                ),
                const Gap(value: 30),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "${AppStrings.availableBalanceAmount}: ${Utils.currentUser.balance}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                ),
                const Gap(value: 20),
                CommonTextFieldWidget(
                  hintText: AppStrings.amount,
                  controller: _amountController,
                  textInputType: TextInputType.number,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.pleaseEnterCorrectNumber;
                    }
                    return null;
                  },
                ),
                const Gap(value: 20),
                SizedBox(
                  height: cubit.isEmptyList ? 0 : 200,
                  child: StatefulBuilder(builder: (ctx, subSetState) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.topupAmountList.length,
                      itemBuilder: (ctx, index) {
                        final amount = cubit.topupAmountList[index];

                        // check for invalid amount and hide the options
                        // if (amount >= Utils.currentUser.balance!) {
                        //   return const SizedBox.shrink();
                        // }

                        final isSelected = _rechargeAmount == amount;
                        return InkWell(
                          onTap: () {
                            _rechargeAmount = amount;
                            _amountController.text = _rechargeAmount.toString();
                            subSetState(() {});
                          },
                          child: Container(
                            height: 50,
                            // margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                amount.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight:
                                      isSelected ? FontWeight.bold : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    );
                  }),
                ),
                const Gap(),
                if (!cubit.isEmptyList)
                  Center(
                    child: BlocConsumer<TopUpCubit, TopUpState>(
                      listener: (ctx, state) {
                        if (state.status == StatusEnum.failed) {
                          Utils.toast(ctx, state.message);
                        }

                        if (state.status == StatusEnum.success) {
                          Utils.toast(ctx, state.message);
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        }
                      },
                      builder: (ctx, state) {
                        return state.status == StatusEnum.loading
                            ? const CommonLoaderWidget()
                            : CommonElevatedButton(
                                title: AppStrings.topUp,
                                onPressed: () {
                                  if (_formState.currentState!.validate()) {
                                    BlocProvider.of<TopUpCubit>(context)
                                        .topUpMobileRecharge(
                                      TopUpEntity(
                                        phoneNumber:
                                            widget.beneficiary.phoneNumber,
                                        nickname: widget.beneficiary.nickname,
                                        amount: num.tryParse(
                                          _amountController.text,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                      },
                    ),
                  ),
                const Gap(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
