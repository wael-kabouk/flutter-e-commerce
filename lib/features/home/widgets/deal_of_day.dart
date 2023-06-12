import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/features/home/services/home_services.dart';
import 'package:e_commerce_app/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    getDealOfDay();
  }

  void getDealOfDay() async {
    product = await homeServices.getDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      )),
                  Image.network(
                    product!.imagesUrls[0],
                    height: 235,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        "\$${product!.price.toString()}",
                        style: const TextStyle(fontSize: 18),
                      )),
                  Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        "A product!",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: product!.imagesUrls
                          .map((anImage) => Image.network(
                                anImage,
                                fit: BoxFit.contain,
                                width: 100,
                                height: 100,
                              ))
                          .toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15)
                        .copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "See all deals",
                      style: TextStyle(color: Colors.cyan[800]),
                    ),
                  )
                ]),
              );
  }
}
