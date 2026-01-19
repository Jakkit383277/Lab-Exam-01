import 'package:flutter/material.dart';
import '../models/product.dart';

// AI-ASSISTED: Detail Screen
class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final daysLeft =
        product.expiryDate.difference(DateTime.now()).inDays;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          Image.network(product.imageUrl,
              height: 250, width: double.infinity, fit: BoxFit.cover),
          const SizedBox(height: 16),
          Text("Category: ${product.category.name}"),
          Text("Expire in $daysLeft days"),
        ],
      ),
    );
  }
}
