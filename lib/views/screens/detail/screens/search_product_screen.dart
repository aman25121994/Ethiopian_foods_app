import 'package:ethiopian_foods_app/controllers/product_controller.dart';
import 'package:ethiopian_foods_app/models/product.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ProductController _productController = ProductController();

  List<Product> _searchedProducts = [];
  bool _isLoading = false;

  void _searchProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        final products = await _productController.searchProducts(query);
        setState(() {
          _searchedProducts = products;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;

    final crossAxisCount = screenwidth < 600 ? 2 : 4;

    final childAspectRatio = screenwidth < 600 ? 3 / 4 : 4 / 5;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: "search foods ...",
            suffixIcon: IconButton(
              onPressed: _searchProducts,
              icon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_searchedProducts.isEmpty)
            const Center(
              child: Text('No Food Found'),
            )
          else
            Expanded(
              child: GridView.builder(
                  itemCount: _searchedProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final product = _searchedProducts[index];
                    return ProductItemWidget(product: product);
                  }),
            )
        ],
      ),
    );
  }
}
