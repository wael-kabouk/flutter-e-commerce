import 'package:e_commerce_app/common/widgets/stars.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;

    double totalRating = 0;
    for (int i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }

    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.network(
                  product.imagesUrls[0],
                  fit: BoxFit.contain,
                  height: 135,
                  width: 135,
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Stars(rating: avgRating)),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: const Text(
                        "Free Shipping",
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        "In Stock",
                        style: TextStyle(color: Colors.teal),
                        maxLines: 2,
                      ),
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
