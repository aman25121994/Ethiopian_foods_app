import 'dart:convert';

import 'package:ethiopian_foods_app/global_variables.dart';
import 'package:ethiopian_foods_app/models/banner_model.dart';
import 'package:http/http.dart' as http;

class BannerController {
  //fetch banner
  Future<List<BannerModel>> loadBanners() async {
    try {
      //send get request
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8 ",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();

        return banners;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        //throw exception
        throw Exception('Failed to Load Banners');
      }
    } catch (e) {
      throw Exception('Error loading Banners: $e');
    }
  }
}
