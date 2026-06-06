import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String shopId;
  final String name;
  final String description;
  final String category;
  final double price;
  final int stock;
  final String imageUrl;

  ProductModel({
    required this.productId,
    required this.shopId,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;;
    return ProductModel(
      productId: doc.id,
      shopId: data['shopId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      stock: data['stock'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
    };
  }
}
