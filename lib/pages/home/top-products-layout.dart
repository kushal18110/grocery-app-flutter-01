import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:grocery_app/components/product-tile.dart';
import 'package:grocery_app/models/product-model.dart';
import 'package:provider/provider.dart';

class TopProducts extends StatefulWidget {
  const TopProducts({super.key});

  @override
  State<TopProducts> createState() => _TopProductsState();
}

class _TopProductsState extends State<TopProducts> {
//add to cart
  void addTocart(Product product) {
    //adding item to cart
    Provider.of<Products>(context, listen: false).addToCart(product);

    //loding circle
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    Timer(Duration(milliseconds: 500), () {
      //dismis of loading circle
      Navigator.pop(context);

      //showing dialoag with message
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Successfuly added to cart'),
            );
          });
    });

    Timer(Duration(milliseconds: 1200), () {
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
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    Timer(Duration(milliseconds: 500), () {
      //dismis of loading circle
      Navigator.pop(context);

      //showing message
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Removed from cart'),
            );
          });
    });

    Timer(Duration(milliseconds: 1200), () {
      //dismiss of message
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
        builder: (context, value, child) => Container(
            height: 180,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: value.fruitList.length - 3,
                itemBuilder: (context, index) {
                  Product item = value.fruitList[index];
                  int existing = value.userCart
                      .indexWhere((items) => items.name == item.name);
                  return productTile(
                    product: item,
                    onTap: () => addTocart(item),
                    remove: () => {
                      if (existing != -1)
                        {
                          removeFromCart(item),
                        }
                    },
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
                            size: 18,
                            color: item.isLiked ? Colors.red : null,
                          ),
                        )),
                  );
                })));
  }
}
