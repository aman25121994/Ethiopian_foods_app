import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final String subCategory;
  final List<String> images;

  Product(
      {required this.id,
      required this.productName,
      required this.description,
      required this.category,
      required this.vendorId,
      required this.fullName,
      required this.subCategory,
      required this.images});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullName': fullName,
      'subCategory': subCategory,
      'images': images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['_id'] as String,
        productName: map['productName'] as String,
        description: map['description'] as String,
        category: map['category'] as String,
        vendorId: map['vendorId'] as String,
        fullName: map['fullName'] as String,
        subCategory: map['subCategory'] as String,
        images: List<String>.from(
          (map['images'] as List<dynamic>),
        ));
  }
  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
