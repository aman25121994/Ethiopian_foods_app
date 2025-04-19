import 'dart:convert';

import 'package:ethiopian_foods_app/models/favorite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>((ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  FavoriteNotifier() : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteString = prefs.getString('favorites');
    if (favoriteString != null) {
      final Map<String, dynamic> favoriteMap = jsonDecode(favoriteString);

      final favorites = favoriteMap
          .map((key, value) => MapEntry(key, Favorite.fromJson(value)));
      state = favorites;
    }
  }

  Future<void> _savedFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteString = jsonEncode(state);
    await prefs.setString('favorites', favoriteString);
  }

  void addProductToFavorite({
    required String productName,
    required String category,
    required List<String> image,
    required String vendorId,
    required String description,
    required String productId,
    required String fullName,
  }) {
    state[productId] = Favorite(
      productName: productName,
      category: category,
      image: image,
      vendorId: vendorId,
      productId: productId,
      description: description,
      fullName: fullName,
    );

    state = {...state};
    _savedFavorites();
  }

  void removeFavoriteItem(String productI) {
    state.remove(productI);

    state = {...state};
    _savedFavorites();
  }

  Map<String, Favorite> get getFavoriteItems => state;
}
