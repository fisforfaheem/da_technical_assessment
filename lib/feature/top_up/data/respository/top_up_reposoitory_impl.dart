import 'package:da_technical_assessment/feature/auth/data/models/user_model.dart';
import 'package:da_technical_assessment/feature/top_up/data/data_source/top_up_remote_data_source.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';
import 'package:da_technical_assessment/feature/top_up/domain/top_up_respository.dart';

class TopUpRemoteRepositoryImpl extends TopUpRemoteRepository {
  final TopUpRemoteDataSource dataSource;

  TopUpRemoteRepositoryImpl({required this.dataSource});

  @override
  Future<TopUpEntity> addBeneficiary(TopUpEntity entity) {
    return dataSource.addBeneficiary(entity);
  }

  @override
  Future<UserEntity> deleteBeneficiary(UserEntity entity) {
    return dataSource.deleteBeneficiary(entity);
  }

  @override
  Future<List<UserEntity>> getTopUpBeneficiaries() {
    return dataSource.getTopUpBeneficiaries();
  }

  @override
  Future<List<UserEntity>> getTopUpHistory() {
    return dataSource.getTopUpHistory();
  }

  @override
  Future<UserEntity> updateBeneficiary(UserEntity entity) {
    return dataSource.updateBeneficiary(entity);
  }

  @override
  Future<void> topUpMobileRecharge(TopUpEntity entity) {
    return dataSource.topUpMobileRecharge(entity);
  }


}
