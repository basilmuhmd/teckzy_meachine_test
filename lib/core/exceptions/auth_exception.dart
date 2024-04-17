import 'package:login_list_products/core/exceptions/base_exception.dart';

final class AuthException extends BaseException {
  final String? error;
  AuthException({this.error})
      : super(message: error ?? "Login failed unexpectedly, please try again");
}
