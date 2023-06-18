import 'package:flutter/material.dart';
import 'package:grocery_app/components/category-list.dart';
import 'package:grocery_app/components/category-tile.dart';
import 'package:grocery_app/pages/all-products-page.dart';
import 'package:provider/provider.dart';

class categoryLayout extends StatelessWidget {
  const categoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryList>(
        builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //bakery
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return allProducts(selectedIndex: 0,);
                      }));
                    },
                    child: CategoryTile(item: value.categoriesList[0])),

                //fruits
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return allProducts(selectedIndex: 1,);
                      }));
                    },
                    child: CategoryTile(item: value.categoriesList[1])),

                //vegetables
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return allProducts(selectedIndex: 2,);
                      }));
                    },
                    child: CategoryTile(item: value.categoriesList[2])),

                //drinks
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return allProducts(selectedIndex: 3,);
                      }));
                    },
                    child: CategoryTile(item: value.categoriesList[3])),
              ],
            ));
  }
}
