import 'package:da_technical_assessment/core/app_strings/app_strings.dart';
import 'package:da_technical_assessment/core/cubit/base_cubit.dart';
import 'package:da_technical_assessment/core/enums/enums.dart';
import 'package:da_technical_assessment/core/utils/top_up_service.dart';
import 'package:da_technical_assessment/core/utils/utils.dart';
import 'package:da_technical_assessment/feature/auth/data/models/user_model.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';
import 'package:da_technical_assessment/feature/top_up/domain/top_up_respository.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_state.dart';

class TopUpCubit extends BaseCubit<TopUpState> {
  List<int> topupAmountList = [5, 10, 20, 30, 50, 75, 100];

  bool get isEmptyList {
    return topupAmountList.isEmpty ||
        (topupAmountList.first > Utils.currentUser.balance!);
  }

  TopUpCubit(this.topUpRepository)
      : super(TopUpState(tabName: AppStrings.recharge)) {
    getBeneficiary();
  }

  //repos
  final TopUpRemoteRepository topUpRepository;

  List<TopUpEntity> beneficiaries = [], history = [];

  // add beneficiary
  Future<void> addBeneficiary(TopUpEntity user) async {
    try {
      emitLoading();

      // topUpRepository.addBeneficiary(user);

      beneficiaries.insert(
        0,
        user.copyWith(),
      );
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(
          status: StatusEnum.success, message: 'successfully added'));
    } catch (e) {
      emit(state.copyWith(
          status: StatusEnum.failed, message: 'something went wrong'));
    }
  }

  // get beneficiary
  Future<void> getBeneficiary() async {
    emitLoading();

    beneficiaries.add(TopUpEntity(
      nickname: 'Ahmad',
      phoneNumber: '+971528783395',
    ));
    beneficiaries.add(TopUpEntity(
      nickname: 'Hashim',
      phoneNumber: '+97152870000',
    ));
    beneficiaries.add(TopUpEntity(
      nickname: 'Amit',
      phoneNumber: '+971258783395',
    ));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: StatusEnum.success));
  }

  // get History
  Future<void> getHistory() async {
    emitLoading();
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: StatusEnum.success));
  }

  Future<void> topUpMobileRecharge(TopUpEntity entity) async {
    try {
      emitLoading();

      if (entity.amount! >= Utils.currentUser.balance!) {
        emit(
          state.copyWith(
            status: StatusEnum.failed,
            message: 'Insufficient balance',
          ),
        );
        return;
      }

      if (TopUpService.isBasedAmountExceedingLimit()) {
        emit(
          state.copyWith(
            status: StatusEnum.failed,
            message: 'Monthly limit exceeded',
          ),
        );
        return;
      }

      if (!TopUpService.processTopUp(entity.phoneNumber!, entity.amount!)) {
        emit(
          state.copyWith(
            status: StatusEnum.failed,
            message: 'Limit exceeded',
          ),
        );
        return;
      }
      //
      // await topUpRepository.topUpMobileRecharge(entity);

      // charges per top-up
      Utils.currentUser.balance = Utils.currentUser.balance! - 1;
      // amount
      Utils.currentUser.balance = Utils.currentUser.balance! - entity.amount!;

      // add to history
      history.add(entity);

      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: StatusEnum.success,
          message: 'successfully top-up',
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StatusEnum.failed));
    }
  }

  // states

  void emitLoading() {
    emit(state.copyWith(status: StatusEnum.loading, message: ''));
  }

  void toggleTab(String name) {
    emit(state.copyWith(tabName: name));
  }

  Future<void> deleteBeneficiary(TopUpEntity user) async {
    try {
      Utils.showLoaderDialog();
      emitLoading();
      //
      // await topUpRepository.deleteBeneficiary(beneficiaries.first);

      // remove from list
      beneficiaries.removeWhere(
        (element) => element.phoneNumber == user.phoneNumber,
      );

      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: StatusEnum.success,
          message: 'successfully deleted',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StatusEnum.failed,
          message: 'something went wrong',
        ),
      );
    }

    Utils.hideDialog();
  }
}
