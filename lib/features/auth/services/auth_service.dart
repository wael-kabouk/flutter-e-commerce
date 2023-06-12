import 'dart:convert';

import 'package:e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          type: "",
          address: "",
          token: "",
          cart: []);
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8"
          });
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: (() => showSnackBar(
                context, "Account created!, Login with the same credential.")));
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8"
          });
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: (() async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              if (context.mounted) {
                Provider.of<UserProvider>(context, listen: false)
                    .setUser(res.body);
              }
              await sharedPreferences.setString(
                  "x-auth-token", jsonDecode(res.body)['token']);
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, BottomBar.routeName, (route) => false);
              }
            }));
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("x-auth-token");

      if (token == null) {
        sharedPreferences.setString("x-auth-token", "");
      }

      http.Response tokenResponse = await http
          .post(Uri.parse("$uri/isTokenValid"), headers: <String, String>{
        'Content-Type': "application/json; charset=UTF-8",
        "x-auth-token": token!
      });

      var response = jsonDecode(tokenResponse.body);

      if (response == true) {
        http.Response userRes = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              'Content-Type': "application/json; charset=UTF-8",
              "x-auth-token": token
            });
        if (context.mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);
        }
      }

      // http.Response res = await http.post(Uri.parse("$uri/api/signin"),
      //     body: jsonEncode({'email': email, 'password': password}),
      //     headers: <String, String>{
      //       'Content-Type': "application/json; charset=UTF-8"
      //     });
      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: (() async {
      //       SharedPreferences sharedPreferences =
      //           await SharedPreferences.getInstance();
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       await sharedPreferences.setString(
      //           "x-auth-token", jsonDecode(res.body)['token']);
      //       Navigator.pushNamedAndRemoveUntil(
      //           context, HomeScreen.routeName, (route) => false);
      //     }));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
