import 'package:dio/dio.dart';

class DioProvider {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://b/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onError: (e, handler) {
          handler.next(e);
        },
      ),
    );
    return dio;
  }
}
