import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_app/common/widgets/custom_button.dart';
import 'package:e_commerce_app/common/widgets/custom_textfield.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();

  final AdminServices adminServices = AdminServices();
  List<File> images = [];
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  String currentCategory = 'Mobiles';
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void postProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.postProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: int.parse(quantityController.text),
          category: currentCategory,
          images: images);
    }
  }

  selectImages() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Add A Product',
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _addProductFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map((i) {
                        return Builder(
                            builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ));
                      }).toList(),
                      options: CarouselOptions(
                          initialPage: 0,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          scrollDirection: Axis.horizontal,
                          height: 200),
                    )
                  : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Select a product image",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          )),
                    ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                  controller: productNameController, hintText: "Product Name"),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: descriptionController,
                hintText: "Description",
                maxLines: 7,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(controller: priceController, hintText: "Price"),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: quantityController, hintText: "Quantity"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: currentCategory,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: productCategories
                      .map((String item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      currentCategory = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(text: "Post", onTap: postProduct),
            ],
          ),
        ),
      )),
    );
  }
}
