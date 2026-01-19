// AI-ASSISTED: Model class สำหรับจัดการข้อมูลสินค้า

enum Category { food, drink, cosmetic, other }

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final Category category;
  final DateTime expiryDate;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.expiryDate,
  });
}
