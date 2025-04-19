import 'dart:convert';

import 'package:ethiopian_foods_app/global_variables.dart';
import 'package:ethiopian_foods_app/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  //load uploaded category

  Future<List<Category>> loadCategories() async {
    try {
      //send get request
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8 ",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();

        return categories;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        //throw exception
        throw Exception('Failed to Load categories');
      }
    } catch (e) {
      throw Exception('Error loading categories: $e');
    }
  }
}
