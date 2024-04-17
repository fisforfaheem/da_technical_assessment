import 'package:da_technical_assessment/feature/auth/data/models/user_model.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';

abstract class TopUpRemoteRepository {
  Future<List<UserEntity>> getTopUpBeneficiaries();

  Future<List<UserEntity>> getTopUpHistory();

  Future<TopUpEntity> addBeneficiary(TopUpEntity entity);

  Future<UserEntity> updateBeneficiary(UserEntity entity);

  Future<UserEntity> deleteBeneficiary(UserEntity entity);

  Future<void> topUpMobileRecharge(TopUpEntity entity);
}
