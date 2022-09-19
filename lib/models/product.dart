import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final List<String> imagesUrls;
  final String category;

  final String? id;
  //rating

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imagesUrls,
    required this.category,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'imagesUrls': imagesUrls,
      'category': category,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      imagesUrls: List<String>.from(map['imagesUrls']),
      category: map['category'] ?? '',
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
