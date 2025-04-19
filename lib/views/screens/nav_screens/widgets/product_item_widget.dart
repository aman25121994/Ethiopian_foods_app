import 'package:ethiopian_foods_app/models/product.dart';
import 'package:ethiopian_foods_app/provider/favorite_provider.dart';
import 'package:ethiopian_foods_app/services/manage_http_response.dart';
import 'package:ethiopian_foods_app/views/screens/detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(product: widget.product);
        }));
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Image.network(
                    widget.product.images[0],
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        favoriteProviderData.addProductToFavorite(
                          productName: widget.product.productName,
                          category: widget.product.category,
                          image: widget.product.images,
                          vendorId: widget.product.vendorId,
                          productId: widget.product.id,
                          description: widget.product.description,
                          fullName: widget.product.fullName,
                        );
                        showSnackBar(
                            context, 'added ${widget.product.productName}');
                      },
                      child: favoriteProviderData.getFavoriteItems
                              .containsKey(widget.product.id)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: const Color(
                  0xFF212121,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.product.category,
              style: GoogleFonts.quicksand(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(
                  0xff868D94,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
