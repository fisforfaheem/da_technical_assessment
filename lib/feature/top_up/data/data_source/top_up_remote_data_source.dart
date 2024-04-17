import 'package:da_technical_assessment/core/network/network_client.dart';
import 'package:da_technical_assessment/core/network/network_constants.dart';
import 'package:da_technical_assessment/core/network/network_exceptions.dart';
import 'package:da_technical_assessment/feature/auth/data/models/user_model.dart';
import 'package:da_technical_assessment/feature/top_up/data/model/topup_entity.dart';

class TopUpRemoteDataSource {
  final NetworkClient client;

  TopUpRemoteDataSource({required this.client});

  Future<TopUpEntity> addBeneficiary(TopUpEntity entity) async {
    try {
      final response = await client.invoke(
        kBeneficiary,
        RequestType.post,
        requestBody: entity.toMap(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return TopUpEntity.fromMap(response.data);
      }
      throw GeneralException(message: response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserEntity> deleteBeneficiary(UserEntity entity) async {
    return UserEntity();
  }

  Future<List<UserEntity>> getTopUpBeneficiaries() async {
    try {
      final response = await client.invoke(
        kBeneficiary,
        RequestType.get,
      );
      if (response.statusCode == 200) {
        return UserEntity.fromJsonToList(response.data);
      }
      throw GeneralException(message: response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserEntity>> getTopUpHistory() async {
    return <UserEntity>[];
  }

  Future<UserEntity> updateBeneficiary(UserEntity entity) async {
    return UserEntity();
  }

  Future<void> topUpMobileRecharge(TopUpEntity entity) async {
    try {
      final response = await client.invoke(
        kBeneficiaryTopUp,
        RequestType.post,
        requestBody: entity.toMap(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return;
      }
      throw GeneralException(message: response.data);
    } catch (e) {
      rethrow;
    }
  }
}
