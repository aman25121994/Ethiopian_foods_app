import 'dart:convert';

import 'package:ethiopian_foods_app/global_variables.dart';
import 'package:ethiopian_foods_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/popular-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<Product> products = data
            .map(
                (products) => Product.fromMap(products as Map<String, dynamic>))
            .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      throw Exception('Error loading popular products: $e');
    }
  }

  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<Product> products = data
            .map(
                (products) => Product.fromMap(products as Map<String, dynamic>))
            .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      throw Exception('Error loading popular products: $e');
    }
  }

  Future<List<Product>> loadProductBySubcategory(String subCategory) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-subcategory/$subCategory'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<Product> products = data
            .map(
                (products) => Product.fromMap(products as Map<String, dynamic>))
            .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load  Foods');
      }
    } catch (e) {
      throw Exception('Error loading popular products: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/search-products?query=$query'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<Product> searchedproducts = data
            .map(
                (products) => Product.fromMap(products as Map<String, dynamic>))
            .toList();
        return searchedproducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load  Searched Food');
      }
    } catch (e) {
      throw Exception('Error loading searched Food: $e');
    }
  }
}
