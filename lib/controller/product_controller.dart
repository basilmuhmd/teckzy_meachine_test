import 'package:login_list_products/models/product_model.dart';
import 'package:login_list_products/services/product_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controller.g.dart';

@riverpod
Future<List<ProductModel>> getProducts(GetProductsRef ref) async {
  return ProductService.getProducts();
}
