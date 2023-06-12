import 'dart:convert';

import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> getCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> products = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-products?category=$category'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token
        },
      );
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              //decode to reach a particular item then encode to model using fromJson().
              var decodedProducts = jsonDecode(res.body);
              for (int i = 0; i < decodedProducts.length; i++) {
                products.add(Product.fromJson(jsonEncode(decodedProducts[i])));
              }
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  Future<Product> getDealOfTheDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
        name: '',
        description: '',
        price: 0,
        quantity: 0,
        imagesUrls: [],
        category: '');

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token
        },
      );
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              product = Product.fromJson(res.body);
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
