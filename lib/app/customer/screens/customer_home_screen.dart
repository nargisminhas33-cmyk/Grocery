import 'package:flutter/material.dart';
import 'package:grossery/app/core/models/shop_model.dart';
import 'package:grossery/app/core/services/firebase_service.dart';
import 'package:grossery/app/customer/screens/shop_details_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
      ),
      body: StreamBuilder<List<ShopModel>>(
        stream: _firebaseService.getDocuments(
          'shops',
          (doc) => ShopModel.fromFirestore(doc),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final shops = snapshot.data!;

          return ListView.builder(
            itemCount: shops.length,
            itemBuilder: (context, index) {
              final shop = shops[index];
              return ListTile(
                title: Text(shop.shopName),
                subtitle: Text(shop.address.toString()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopDetailsScreen(shopId: shop.shopId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
