import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/models/categories-model.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.item});
  final CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //image
          Container(
            padding: EdgeInsets.all(14),
            decoration:
                BoxDecoration(color: item.backColor, borderRadius: curve),
            height: 60,
            width: 60,
            child: Center(
              child: Image.asset(item.imgPath),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          Text(
            item.itemName,
            style: TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }
}
