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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<AddBeneficiaryScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  late final TopUpCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TopUpCubit>(context);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addBeneficiary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              CommonTextFieldWidget(
                hintText: AppStrings.phoneNumber,
                controller: _phoneController,
                textInputType: TextInputType.phone,
                validation: (txt) {
                  // UAE phone number regular expression
                  RegExp regex = RegExp(r'^\+?971([0-9]{9})$');
                  return txt!.isEmpty
                      ? AppStrings.pleaseEnterText
                      : (!regex.hasMatch(txt))
                          ? AppStrings.pleaseEnterCorrectNumber
                          : null;
                },
              ),
              const Gap(),
              CommonTextFieldWidget(
                hintText: AppStrings.nickname,
                controller: _nicknameController,
                maxLength: 20,
                validation: (txt) {
                  return txt!.isEmpty ? AppStrings.pleaseEnterText : null;
                },
              ),
              const Gap(),
              BlocConsumer<TopUpCubit, TopUpState>(
                listener: (ctx, state) {
                  if (state.status == StatusEnum.failed) {
                    Utils.toast(ctx, state.message);
                  }

                  if (state.status == StatusEnum.success) {
                    Utils.toast(ctx, state.message);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
                builder: (ctx, state) {
                  return state.status == StatusEnum.loading
                      ? const CommonLoaderWidget()
                      : CommonElevatedButton(
                          title: AppStrings.addBeneficiary,
                          onPressed: () {
                            if (_formState.currentState!.validate()) {
                              cubit.addBeneficiary(
                                TopUpEntity(
                                  phoneNumber: _phoneController.text,
                                  nickname: _nicknameController.text,
                                ),
                              );
                            }
                          },
                        );
                },
              ),
              const Gap(),
            ],
          ),
        ),
      ),
    );
  }
}
