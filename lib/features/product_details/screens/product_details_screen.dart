import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/common/widgets/custom_button.dart';
import 'package:e_commerce_app/common/widgets/stars.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/search/screens/search_screen.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        height: 42,
                        margin: const EdgeInsets.only(left: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                                prefixIcon: InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: 23,
                                      )),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(top: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                hintText: "Search",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17)),
                          ),
                        )),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                ]),
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.product.id!), const Stars(rating: 4)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.product.name,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            CarouselSlider(
              items: widget.product.imagesUrls.map((i) {
                return Builder(
                    builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: 200,
                        ));
              }).toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  scrollDirection: Axis.horizontal,
                  height: 300),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: TextSpan(
                      text: 'Deal Price: ',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text: '\$${widget.product.price}',
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                            fontWeight: FontWeight.w500))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(text: "Buy Now", onTap: () {}),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: "Add to Cart",
                onTap: () {},
                color: const Color.fromARGB(255, 225, 137, 231),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Rate The Product",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    ),
                onRatingUpdate: (rating) {})
          ]),
        ));
  }
}
