import 'package:flutter/material.dart';
import '../models/product.dart';

// AI-ASSISTED: Form Validation 3 fields
class ProductFormScreen extends StatefulWidget {
  final Product? edit;
  const ProductFormScreen({super.key, this.edit});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String imageUrl = '';
  Category category = Category.food;
  DateTime expiry = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Form")),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Product Name"),
              validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
              onSaved: (v) => name = v!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Image URL"),
              validator: (v) =>
                  v == null || !v.startsWith("http") ? "Invalid URL" : null,
              onSaved: (v) => imageUrl = v!,
            ),
            DropdownButtonFormField<Category>(
              value: category,
              items: Category.values
                  .map((c) =>
                      DropdownMenuItem(value: c, child: Text(c.name)))
                  .toList(),
              onChanged: (v) => setState(() => category = v!),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.pop(
                    context,
                    Product(
                      id: widget.edit?.id ??
                          DateTime.now().toString(),
                      name: name,
                      imageUrl: imageUrl,
                      category: category,
                      expiryDate: expiry,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
