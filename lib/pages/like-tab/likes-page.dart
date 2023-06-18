import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:grocery_app/models/product-model.dart';
import 'package:grocery_app/pages/like-tab/like-tile.dart';
import 'package:provider/provider.dart';

class likePage extends StatefulWidget {
  const likePage({super.key});

  @override
  State<likePage> createState() => _likePageState();
}

class _likePageState extends State<likePage> {
  @override
  Widget build(BuildContext context) {
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

    return Consumer<Products>(
        builder: (context, value, child) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Text(
                        'Liked Products',
                        style: TextStyle(fontSize: 27),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: value.likedList.length,
                            itemBuilder: (context, index) {
                              Product eachItem = value.likedList[index];

                              return likeTile(
                                item: eachItem,
                                add: () => addTocart(eachItem),
                                remove: () {},
                                onSelected: (value) => {
                                  //loading circle
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }),
                                  Timer(const Duration(milliseconds: 500), () {
                                    //dismiss of loading circle
                                    Navigator.pop(context);

                                    //message show
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return const AlertDialog(
                                            title: Text(
                                                "Removed from liked products"),
                                          );
                                        });
                                    Provider.of<Products>(context,
                                            listen: false)
                                        .removeFromLikeList(eachItem);

                                    Timer(const Duration(milliseconds: 1000), () {
                                      //message dismiss
                                      Navigator.pop(context);
                                    });
                                  })
                                },
                              );
                            }))
                  ],
                ),
              ),
            ));
  }
}
