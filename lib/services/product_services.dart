import 'package:dio/dio.dart';
import 'package:login_list_products/core/exceptions/product_exception.dart';
import 'package:login_list_products/models/product_model.dart';

final class ProductService {
  static final _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  static Future<List<ProductModel>> getProducts() async {
    try {
      final res = await _dio.get("/products");

      return (res.data['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw GetProductException(error: e.response?.data['message'].toString());
    }
  }
}
