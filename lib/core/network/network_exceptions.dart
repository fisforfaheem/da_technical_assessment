
class Exception {
  final String message;

  const Exception({required this.message});
}

class NoInternetException extends Exception {
  NoInternetException({required super.message});
}

// server error
class ServerException extends Exception {
  ServerException({required super.message});
}

// cache error
class CacheException extends Exception {
  CacheException({required super.message});
}

// SocketException
class SocketException extends Exception {
  SocketException({required super.message});
}

// dio error
class DioExceptionNetwork extends Exception {
  DioExceptionNetwork({required super.message});
}

class NotFoundException extends Exception {
  NotFoundException({required super.message});
}

class BadRequestException extends Exception {
  BadRequestException({required super.message});
}

class GeneralException extends Exception {
  GeneralException({required super.message});
}

// exception handler in extension
// extension ExceptionHandler on Exception {
//   String get message {
//     switch (runtimeType) {
//       case NoInternetException:
//         return AppStrings.noInternetConnection;
//       case ServerException:
//         return AppStrings.serverError;
//       case CacheException:
//         return 'Cache Error';
//       case DioExceptionNetwork:
//         return 'Dio Error';
//       case SocketException:
//         return 'Socket Error';
//       case UnauthorizedException:
//         return 'Authentication failed';
//       case NotFoundException:
//         return 'The requested resource could not be found on the server.';
//
//       default:
//         return 'Unknown Error';
//     }
//   }
// }
