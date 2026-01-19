import 'package:flutter/material.dart';
import '../models/product.dart';

// AI-ASSISTED: Provider สำหรับจัดการ State
class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void add(Product p) {
    _products.add(p);
    notifyListeners();
  }

  void remove(String id) {
    _products.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void update(Product newProduct) {
    final index = _products.indexWhere((p) => p.id == newProduct.id);
    if (index != -1) {
      _products[index] = newProduct;
      notifyListeners();
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _products.removeAt(oldIndex);
    _products.insert(newIndex, item);
    notifyListeners();
  }
}
