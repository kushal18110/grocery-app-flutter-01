import 'package:flutter/material.dart';
import 'package:grocery_app/models/categories-model.dart';

class CategoryList extends ChangeNotifier {
  final List<CategoryItem> categoriesList = [
    CategoryItem(
        itemName: 'Bakery',
        imgPath: 'lib/images/bakery.png',
        backColor: const Color(0xFFfbe7ab)),
    CategoryItem(
        itemName: 'Fruits',
        imgPath: 'lib/images/fruit-2.png',
        backColor: const Color(0xFFdfecf7)),
    CategoryItem(
        itemName: 'Vegetables',
        imgPath: 'lib/images/vegetables.png',
        backColor: const Color(0xFFe2f2c4)),
    CategoryItem(
        itemName: 'Drinks',
        imgPath: 'lib/images/water-bottle.png',
        backColor: const Color(0xFFffdbc6)),
  ];

  //making list avalaible every where
  List<CategoryItem> get categoryList => categoryList;
}
