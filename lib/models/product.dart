import 'dart:convert';

import 'package:e_commerce_app/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final List<String> imagesUrls;
  final String category;

  final String? sellerId;

  final String? id;
  //rating
  final List<Rating>? ratings;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.imagesUrls,
      required this.category,
      this.sellerId,
      this.id,
      this.ratings});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'imagesUrls': imagesUrls,
      'category': category,
      'sellerId': sellerId,
      'id': id,
      'ratings': ratings
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
        sellerId: map['sellerId'] ?? '',
        id: map['_id'],
        ratings: map['ratings'] != null
            ? List<Rating>.from(map['ratings']?.map((x) => Rating.fromMap(x)))
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
