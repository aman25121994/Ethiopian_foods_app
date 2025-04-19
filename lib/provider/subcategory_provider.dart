import 'package:ethiopian_foods_app/models/subcategory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubcategoryProvider extends StateNotifier<List<SubCategory>> {
  SubcategoryProvider() : super([]);

  void setSubcategories(List<SubCategory> subcategories) {
    state = subcategories;
  }
}

final subcategoryProvider =
    StateNotifierProvider<SubcategoryProvider, List<SubCategory>>((ref) {
  return SubcategoryProvider();
});
