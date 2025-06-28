import 'package:ethiopian_foods_app/controllers/product_controller.dart';
import 'package:ethiopian_foods_app/controllers/subcategory_controller.dart';
import 'package:ethiopian_foods_app/models/category.dart';
import 'package:ethiopian_foods_app/models/product.dart';
import 'package:ethiopian_foods_app/models/subcategory.dart';
import 'package:ethiopian_foods_app/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:ethiopian_foods_app/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:ethiopian_foods_app/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';
import 'package:ethiopian_foods_app/views/screens/detail/subcategory_product_screen.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<SubCategory>> _subCategories;
  late Future<List<Product>> futureProducts;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subCategories = _subcategoryController
        .getSubCategoriesByCategoryName(widget.category.name);
    futureProducts =
        ProductController().loadProductByCategory(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
        child: const InnerHeaderWidget(),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          InnerBannerWidget(image: widget.category.banner),
          Center(
            child: Text(
              '',
              style: GoogleFonts.quicksand(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.7,
              ),
            ),
          ),
          FutureBuilder(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                } else {
                  final subcategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate((subcategories.length / 7).ceil(),
                          (setIndex) {
                        final start = setIndex * 7;
                        final end = (setIndex + 1) * 7;

                        return Padding(
                          padding: EdgeInsets.all(8.9),
                          child: Row(
                            children: subcategories
                                .sublist(
                                    start,
                                    end > subcategories.length
                                        ? subcategories.length
                                        : end)
                                .map((subcategory) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return SubcategoryProductScreen(
                                              subcategory: subcategory);
                                        }));
                                      },
                                      child: SubcategoryTileWidget(
                                        image: subcategory.image,
                                        title: subcategory.subCategoryName,
                                      ),
                                    ))
                                .toList(),
                          ),
                        );
                      }),
                    ),
                  );
                }
              }),
          const ReusableTextWidget(title: 'Popular Foods', subtitle: ''),
          FutureBuilder(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Foods found under this category'),
                );
              } else {
                final products = snapshot.data;
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductItemWidget(
                          product: product,
                        );
                      }),
                );
              }
            },
          ),
        ],
      )),
    );
  }
}
