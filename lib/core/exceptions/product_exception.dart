import 'package:login_list_products/core/exceptions/base_exception.dart';

final class GetProductException extends BaseException {
  final String? error;
  GetProductException({this.error})
      : super(
            message: error ??
                "Falied to load products from server, please try again");
}
