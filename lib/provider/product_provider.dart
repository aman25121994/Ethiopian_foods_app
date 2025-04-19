import 'package:ethiopian_foods_app/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductProvider extends StateNotifier<List<Product>> {
  ProductProvider() : super([]);

  void setProducts(List<Product> products) {
    state = products;
  }
}

final productProvider =
    StateNotifierProvider<ProductProvider, List<Product>>((ref) {
  return ProductProvider();
});
