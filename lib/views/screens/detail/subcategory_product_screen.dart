import 'package:ethiopian_foods_app/controllers/product_controller.dart';
import 'package:ethiopian_foods_app/models/subcategory.dart';
import 'package:ethiopian_foods_app/provider/subcategory_product_provider.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubcategoryProductScreen extends ConsumerStatefulWidget {
  final SubCategory subcategory;

  const SubcategoryProductScreen({super.key, required this.subcategory});

  @override
  ConsumerState<SubcategoryProductScreen> createState() =>
      _SubcategoryProductScreenState();
}

class _SubcategoryProductScreenState
    extends ConsumerState<SubcategoryProductScreen> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final products = ref.read(subcategoryProductProvider);
    if (products.isEmpty) {
      _fetchProduct();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController
          .loadProductBySubcategory(widget.subcategory.subCategoryName);
      ref.read(subcategoryProductProvider.notifier).setProducts(products);
    } catch (e) {
      print('$e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(subcategoryProductProvider);
    final screenwidth = MediaQuery.of(context).size.width;

    final crossAxisCount = screenwidth < 600 ? 2 : 4;

    final childAspectRatio = screenwidth < 600 ? 3 / 4 : 4 / 5;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subcategory.subCategoryName,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItemWidget(product: product);
                  }),
            ),
    );
  }
}
