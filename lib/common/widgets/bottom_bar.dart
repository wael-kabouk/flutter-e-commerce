import 'package:badges/badges.dart' as badge;
import 'package:e_commerce_app/features/cart/screens/cart_screen.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/account/screens/account_screen.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({Key? key}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentPage = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 3;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int nextPage) {
    setState(() {
      _currentPage = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //home
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _currentPage == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor,
                  width: bottomBarBorderWidth,
                ))),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          //account
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _currentPage == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor,
                  width: bottomBarBorderWidth,
                ))),
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _currentPage == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor,
                  width: bottomBarBorderWidth,
                ))),
                child: badge.Badge(
                    elevation: 0,
                    badgeContent: Text(userCartLen.toString()),
                    badgeColor: Colors.white,
                    child: const Icon(Icons.shopping_cart_outlined)),
              ),
              label: ''),
        ],
      ),
    );
  }
}
