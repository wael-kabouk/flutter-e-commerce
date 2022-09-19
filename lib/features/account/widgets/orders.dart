import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List products = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  "Your Orders",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),
            Container(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "See all",
                  style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                ))
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          height: 170,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return SingleProduct(
                  image: products[index],
                );
              }),
        )
      ],
    );
  }
}
