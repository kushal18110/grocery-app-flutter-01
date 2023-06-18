
import 'package:flutter/material.dart';

class Product {
  final String name;
  final String price;
  final String imgPath;
  final Color backColor;
  int quantity;
   bool isLiked;
   
   Product({required this.name, required this.price, required this.imgPath, required this.backColor,
    this.quantity = 1, required this.isLiked});


}