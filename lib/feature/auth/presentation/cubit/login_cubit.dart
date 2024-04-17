import 'package:da_technical_assessment/core/cubit/base_cubit.dart';
import 'package:da_technical_assessment/core/cubit/login_state.dart';
import 'package:da_technical_assessment/core/enums/enums.dart';
import 'package:da_technical_assessment/core/utils/utils.dart';
import 'package:da_technical_assessment/feature/auth/data/models/user_model.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginState());

  // demo login users
  List<UserEntity> loginUsers = [
    UserEntity(
      username: 'verify_login',
      email: 'verify_login@gmail.com',
      password: '123',
      isVerified: true,
      balance: 5000,
    ),
    UserEntity(
      username: 'login',
      email: 'login@gmail.com',
      password: '123',
      isVerified: false,
      balance: 5000,
    ),
  ];

  Future<void> login(String username, String password) async {
    try {
      emit(state.copyWith(status: StatusEnum.loading));

      // calling api method to get the login state.
      await Future.delayed(const Duration(seconds: 2));
      final UserEntity user = loginUsers.firstWhere(
          (element) =>
              element.username == username && element.password == password,
          orElse: () => UserEntity());

      //
      if (user.username?.isNotEmpty ?? false) {
        // for dummy save Other wise will use SharePreferences to store data
        // sl<PreferenceUtils>().storeUser(user);
        Utils.currentUser = user;

        //
        emit(state.copyWith(status: StatusEnum.success));
      } else {
        emit(state.copyWith(
            status: StatusEnum.failed, message: 'User not found'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: StatusEnum.failed, message: 'Something went wrong'));
    }
  }
}
