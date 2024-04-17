import 'package:da_technical_assessment/core/di/injection_container.dart';
import 'package:da_technical_assessment/core/network/network_exceptions.dart';
import 'package:da_technical_assessment/core/network/network_info.dart';
import 'package:da_technical_assessment/core/utils/utils.dart';
import 'package:dio/dio.dart';

class NetworkClient {
  final Dio dio;

  NetworkClient({required this.dio});

  Future<Response> invoke(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic requestBody,
    bool isBytes = false,
  }) async {
    // return if base url is  empty
    if (dio.options.baseUrl.isEmpty) {
      throw ServerException(message: 'Base url is empty');
    }

    if (!(await sl<NetworkInfo>().isConnected)) {
      throw NoInternetException(message: 'Network is not connected');
    }

    Response? response;

    try {
      if (isBytes) {
        response = await dio.get(
          url,
          queryParameters: queryParameters,
          options: Options(
            responseType: ResponseType.bytes,
            headers: headers,
          ),
        );
        return response;
      }
      switch (requestType) {
        case RequestType.get:
          response = await dio.get(url,
              queryParameters: queryParameters,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.post:
          response = await dio.post(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.put:
          response = await dio.put(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.delete:
          response = await dio.delete(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.patch:
          response = await dio.patch(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
      }
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      }

      throw GeneralException(message: 'Something went wrong!');
    } on DioError catch (dioError) {
      Utils.debug('$runtimeType on DioError:-  $dioError', StackTrace.current);
      throw _handleError(dioError);
    } on SocketException catch (exception) {
      Utils.debug(
          '$runtimeType on SocketException:-  $exception', StackTrace.current);

      rethrow;
    }
  }

  Exception _handleError(DioError dioError) {
    try {
      final error = dioError.response?.data != null
          ? (dioError.response!.data as Map<String, dynamic>)
          : null;
      switch (dioError.response?.statusCode) {
        case 400:
          return BadRequestException(
              message: error?['error_description'] ??
                  '400: The resource does not exist!');
        case 405:
          return NotFoundException(
              message: dioError.message ?? '405: The resource does not exist!');
        case 500:
        default:
          return ServerException(
            message: error?['error'] ?? 'Server is not responding!',
          );
      }
    } catch (e) {
      return GeneralException(
        message: e.toString(),
      );
    }
  }
}

enum RequestType { get, post, put, delete, patch }
