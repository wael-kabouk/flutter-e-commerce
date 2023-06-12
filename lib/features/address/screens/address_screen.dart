import 'package:e_commerce_app/common/widgets/custom_textField.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/address/services/address_services.dart';
import 'package:e_commerce_app/features/search/screens/search_screen.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');

  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('applepay.json');
  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  if (address.isNotEmpty)
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              address,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  Form(
                    key: _addressFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: flatBuildingController,
                          hintText: 'Flat, House no, Building',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: areaController,
                          hintText: 'Area, Street',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: pincodeController,
                          hintText: 'Pincode',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: cityController,
                          hintText: 'Town/City',
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  FutureBuilder<PaymentConfiguration>(
                      future: _applePayConfigFuture,
                      builder: (context, snapshot) => snapshot.hasData
                          ? ApplePayButton(
                              height: 50,
                              onPressed: () => payPressed(address),
                              paymentConfiguration: snapshot.data!,
                              paymentItems: paymentItems,
                              type: ApplePayButtonType.buy,
                              margin: const EdgeInsets.only(top: 15.0),
                              onPaymentResult: onApplePayResult,
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink()),
                  const SizedBox(height: 10),
                  FutureBuilder<PaymentConfiguration>(
                      future: _googlePayConfigFuture,
                      builder: (context, snapshot) => snapshot.hasData
                          ? GooglePayButton(
                              width: double.infinity,
                              height: 50,
                              onPressed: () => payPressed(address),
                              paymentConfiguration: snapshot.data!,
                              paymentItems: paymentItems,
                              type: GooglePayButtonType.buy,
                              margin: const EdgeInsets.only(top: 15.0),
                              onPaymentResult: onGooglePayResult,
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink()),
                ]))));
  }
}
