import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:grocery_app/models/product-model.dart';
import 'package:provider/provider.dart';

import '../bakery/bakery-tile.dart';

class myDrinks extends StatefulWidget {
  const myDrinks({super.key});

  @override
  State<myDrinks> createState() => _myDrinksState();
}

class _myDrinksState extends State<myDrinks> {
  //add to cart
  void addTocart(Product product) {
    //adding item to cart
    Provider.of<Products>(context, listen: false).addToCart(product);

    //loding circle
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    Timer(const Duration(milliseconds: 500), () {
      //dismis of loading circle
      Navigator.pop(context);

      //showing dialoag with message
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
      //dismiss of message
      Navigator.pop(context);
    });
  }

  //remove from cart
  void removeFromCart(Product product) {
    //remove from cart
    Provider.of<Products>(context, listen: false).removeFromCart(product);

    //loading circle
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    Timer(const Duration(milliseconds: 500), () {
      //dismis of loading circle
      Navigator.pop(context);

      //showing message
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
      //dismiss of message
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
        builder: (context, value, child) => SizedBox(
            height: 380,
            width: double.infinity,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.drinkList.length,
                itemBuilder: (context, index) {
                  Product item = value.drinkList[index];
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
                            item.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
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
                })));
  }
}
