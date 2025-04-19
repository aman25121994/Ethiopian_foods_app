import 'package:ethiopian_foods_app/models/product.dart';
import 'package:ethiopian_foods_app/provider/favorite_provider.dart';
import 'package:ethiopian_foods_app/services/manage_http_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.productName,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              favoriteProviderData.addProductToFavorite(
                productName: widget.product.productName,
                category: widget.product.category,
                image: widget.product.images,
                vendorId: widget.product.vendorId,
                productId: widget.product.id,
                description: widget.product.description,
                fullName: widget.product.fullName,
              );
              showSnackBar(context, 'added ${widget.product.productName}');
            },
            icon: favoriteProviderData.getFavoriteItems
                    .containsKey(widget.product.id)
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 260,
              height: 275,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 50,
                    child: Container(
                      width: 260,
                      height: 260,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(
                          0XFFD8DDFF,
                        ),
                        borderRadius: BorderRadius.circular(130),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 0,
                    child: Container(
                      width: 216,
                      height: 274,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9CABFF),
                        borderRadius: BorderRadiusDirectional.circular(
                          14,
                        ),
                      ),
                      child: SizedBox(
                        height: 300,
                        child: PageView.builder(
                            itemCount: widget.product.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Image.network(
                                widget.product.images[index],
                                width: 198,
                                height: 225,
                                fit: BoxFit.cover,
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName,
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: const Color(
                      0xFF3C55Ef,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.category,
              style: GoogleFonts.roboto(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description,Recipes and Health tips',
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    letterSpacing: 1.7,
                    color: const Color(
                      0xFF363330,
                    ),
                  ),
                ),
                Text(
                  widget.product.description,
                  style: GoogleFonts.roboto(
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
