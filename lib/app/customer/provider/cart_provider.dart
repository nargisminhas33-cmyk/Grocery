import 'package:flutter/material.dart';
import 'package:grossery/app/core/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, ProductModel> _items = {};

  Map<String, ProductModel> get items => _items;

  double get totalAmount {
    double total = 0;
    _items.forEach((key, product) {
      total += product.price;
    });
    return total;
  }

  void addItem(ProductModel product) {
    _items.putIfAbsent(product.productId, () => product);
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
