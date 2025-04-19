import 'dart:convert';

class Favorite {
  final String productName;
  final String category;
  final List<String> image;
  final String vendorId;
  final String description;
  final String fullName;
  final String productId;

  Favorite({
    required this.productName,
    required this.category,
    required this.image,
    required this.vendorId,
    required this.description,
    required this.fullName,
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'category': category,
      'image': image,
      'vendorId': vendorId,
      'description': description,
      'fullName': fullName,
      'productId': productId,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      productName: map['productName'] as String,
      category: map['category'] as String,
      image: List<String>.from(
        (map['image'] as List<dynamic>),
      ),
      vendorId: map['vendorId'] as String,
      description: map['description'] as String,
      fullName: map['fullName'] as String,
      productId: map['productId'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source) as Map<String, dynamic>);
}
