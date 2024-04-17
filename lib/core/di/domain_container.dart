import 'package:da_technical_assessment/feature/top_up/data/data_source/top_up_remote_data_source.dart';
import 'package:da_technical_assessment/feature/top_up/data/respository/top_up_reposoitory_impl.dart';
import 'package:da_technical_assessment/feature/top_up/domain/top_up_respository.dart';

import 'injection_container.dart';

Future<void> initDomainDI() async {
  // REPOSITORY
  sl.registerLazySingleton<TopUpRemoteRepository>(
    () => TopUpRemoteRepositoryImpl(
      dataSource: sl<TopUpRemoteDataSource>(),
    ),
  );
}
