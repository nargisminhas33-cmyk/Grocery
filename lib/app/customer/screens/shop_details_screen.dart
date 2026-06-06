import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grossery/app/core/models/product_model.dart';
import 'package:grossery/app/core/services/firebase_service.dart';
import 'package:grossery/app/customer/provider/cart_provider.dart';
import 'package:grossery/app/customer/screens/cart_screen.dart';

class ShopDetailsScreen extends StatelessWidget {
  final String shopId;
  final FirebaseService _firebaseService = FirebaseService();

  ShopDetailsScreen({required this.shopId});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Details'),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _firebaseService.getDocuments(
          'products',
          (doc) => ProductModel.fromFirestore(doc),
        ).map((products) => products.where((p) => p.shopId == shopId).toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('\${product.price}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cart.addItem(product);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
