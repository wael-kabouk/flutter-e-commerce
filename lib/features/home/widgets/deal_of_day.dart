import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Deal of the day",
            style: TextStyle(fontSize: 20),
          )),
      Image.asset(
        "assets/images/logo.png",
        height: 235,
        fit: BoxFit.fitHeight,
      ),
      Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: const Text(
            "\$500",
            style: TextStyle(fontSize: 18),
          )),
      Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            "A product!",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
        alignment: Alignment.topLeft,
        child: Text(
          "See all deals",
          style: TextStyle(color: Colors.cyan[800]),
        ),
      )
    ]);
  }
}
