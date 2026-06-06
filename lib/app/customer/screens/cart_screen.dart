import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grossery/app/customer/provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final product = cart.items.values.toList()[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cart.removeItem(product.productId);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Text('Total: \${cart.totalAmount}'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Place the order
            },
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
