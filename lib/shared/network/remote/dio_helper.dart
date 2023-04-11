import 'package:dio/dio.dart';
import 'package:my_gallery_app_promina/shared/network/remote/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required url, Map<String, dynamic>? query, String? token}) async {
    dio!.options.headers = {
      'content-type': 'application/json',
      'Authorization': "Bearer ${token}"
    };
    return await dio!.get(url);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    var data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token != null ? "Bearer $token" : "",
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data ?? "",
    );
  }
}
