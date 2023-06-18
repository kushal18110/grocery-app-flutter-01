import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/product-model.dart';
import 'package:grocery_app/pages/home/components/bakery/bakery-tile.dart';
import 'package:provider/provider.dart';
import '../../../../components/product-list.dart';

class myVegetables extends StatefulWidget {
  const myVegetables({super.key});

  @override
  State<myVegetables> createState() => _myVegetablesState();
}

class _myVegetablesState extends State<myVegetables> {
  //add to cart
  void addTocart(Product product) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    Timer(const Duration(milliseconds: 500), () {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Successfuly added to cart'),
            );
          });
    });

    Timer(const Duration(milliseconds: 1200), () {
      Navigator.pop(context);
    });
    Provider.of<Products>(context, listen: false).addToCart(product);
  }

  //remove from cart
  void removeFromCart(Product product) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    Timer(const Duration(milliseconds: 500), () {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Removed from cart'),
            );
          });
    });

    Timer(const Duration(milliseconds: 1200), () {
      Navigator.pop(context);
    });
    Provider.of<Products>(context, listen: false).removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (context, value, child) => SizedBox(
          height: 380,
          width: double.infinity,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.vegetableList.length - 2,
              itemBuilder: (context, index) {
                Product item = value.vegetableList[index];
                int existing = value.userCart
                    .indexWhere((items) => items.name == item.name);

                return bakeryTile(
                  item: item,
                  icon: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (item.isLiked) {
                            Provider.of<Products>(context, listen: false)
                                .removeFromLikeList(item);
                            item.isLiked = false;
                          } else {
                            Provider.of<Products>(context, listen: false)
                                .addToLikeList(item);
                            item.isLiked = true;
                          }
                        });
                      },
                      child: Container(
                        child: Icon(
                          item.isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 23,
                          color: item.isLiked ? Colors.red : null,
                        ),
                      )),
                  add: () => addTocart(item),
                  remove: () => {
                    if (existing != -1)
                      {
                        removeFromCart(item),
                      }
                  },
                );
              })),
    );
    
  }
}
