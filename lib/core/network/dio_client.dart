import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal(){
    dio = Dio(
      BaseOptions(
        baseUrl: '',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json'
        }
      ),
    );
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: (options, handler) {
            print('Request: ${options.method} ${options.path}');
            return handler.next(options);
          },
          onResponse: (response, handler) {
            print('Response: ${response.statusCode} ${response.requestOptions.path}');
            return handler.next(response);
          },
          onError: (error, handler) {
            print('Error: ${error.response?.statusCode} ${error.requestOptions.path}');
            return handler.next(error);
          }
      )

    );

  }
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }
  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }
  Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }
  Future<Response> delete(String path, {dynamic data}) async {
    return await dio.delete(path);
  }
}