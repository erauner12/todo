import 'package:dio/dio.dart';
import 'package:todo/core/util/storage.dart';
import 'package:uuid/uuid.dart';

Dio createDio(Storage storage) {
  final dio = Dio();

  dio.options.headers = {
    'Content-Type': 'application/json',
  };
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.getApiToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        // Add X-Request-Id header
        options.headers['X-Request-Id'] = const Uuid().v4();
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // Handle errors globally if needed
        return handler.next(e);
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
  ));

  return dio;
}