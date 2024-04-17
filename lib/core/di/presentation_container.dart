import 'package:da_technical_assessment/core/di/injection_container.dart';
import 'package:da_technical_assessment/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:da_technical_assessment/feature/top_up/domain/top_up_respository.dart';
import 'package:da_technical_assessment/feature/top_up/presentation/cubit/topup_cubit.dart';

Future<void> initPresentationDI() async {
  sl.registerLazySingleton<LoginCubit>(
    () => LoginCubit(),
  );

  sl.registerLazySingleton<TopUpCubit>(
    () => TopUpCubit(
      sl<TopUpRemoteRepository>(),
    ),
  );
}
