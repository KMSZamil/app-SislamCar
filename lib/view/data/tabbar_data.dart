import 'package:flutter/material.dart';

class TabbarData {
  late IconData img;
  late String name;
  TabbarData(this.img, this.name);
  static List<TabbarData> tabbarData = [
    TabbarData(Icons.credit_card, "Buy"),
    TabbarData(Icons.money, "Sell"),
    TabbarData(Icons.car_rental, "Exchange"),
  ];
}
