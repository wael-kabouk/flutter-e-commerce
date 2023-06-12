import "package:e_commerce_app/common/widgets/custom_button.dart";
import "package:e_commerce_app/constants/global_variables.dart";
import "package:e_commerce_app/features/address/screens/address_screen.dart";
import "package:e_commerce_app/features/cart/widgets/cart_product.dart";
import "package:e_commerce_app/features/cart/widgets/cart_subtotal.dart";
import "package:e_commerce_app/features/home/widgets/address_box.dart";
import "package:e_commerce_app/features/search/screens/search_screen.dart";
import "package:e_commerce_app/providers/user_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  navigateToAddressScreen(int total) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: total.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int total = 0;
    user.cart
        .map((e) => total += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
        child: Column(children: [
          const AddressBox(),
          const CartSubtotal(),
          CustomButton(
            text: 'Proceed to buy (${user.cart.length} items)',
            onTap: () => navigateToAddressScreen(total),
            color: const Color.fromARGB(255, 107, 227, 183),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            itemCount: user.cart.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CartProduct(
                index: index,
              );
            },
          ),
        ]),
      ),
    );
  }
}