import 'package:dio/dio.dart';
import 'package:login_list_products/core/exceptions/auth_exception.dart';
import 'package:login_list_products/models/auth_model.dart';

final class AuthServices {
  static final _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  static Future<AuthModel> loginWithUserNameAndPassowrd(
      String userName, String password) async {
    try {
      final res = await _dio.post(
        '/auth/login',
        data: {
          "username": userName,
          "password": password,
        },
      );
      return AuthModel.fromJson(res.data);
    } on DioException catch (e) {
      throw AuthException(error: e.response?.data['message']);
    }
  }
}
