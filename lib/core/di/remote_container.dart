import 'package:da_technical_assessment/core/di/injection_container.dart';
import 'package:da_technical_assessment/core/network/network_client.dart';
import 'package:da_technical_assessment/feature/top_up/data/data_source/top_up_remote_data_source.dart';

Future<void> initRemoteDI() async {
  sl.registerLazySingleton<TopUpRemoteDataSource>(
    () => TopUpRemoteDataSource(
      client: sl<NetworkClient>(),
    ),
  );
}
