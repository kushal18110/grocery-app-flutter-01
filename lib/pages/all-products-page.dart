import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:grocery_app/models/product-model.dart';
import 'package:grocery_app/pages/home/components/bakery/bakery-tile.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as Badges;

import 'home/cart-page.dart';

class allProducts extends StatefulWidget {
  allProducts({
    super.key,
    required this.selectedIndex,
  });
  int selectedIndex;

  @override
  State<allProducts> createState() => _allProductsState();
}

class _allProductsState extends State<allProducts> {
  // main title
  List<String> titleName = ['Bakery', 'Fruits', 'Vegetables', 'Drinks'];

  //color list
  List<Color> back = [lightyellow, lightblue, lightgreen, lightpink];

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

  void goToCartPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return cartPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
        builder: ((context, value, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                actions: [
                  Row(
                    children: [
                      //badge
                      Badges.Badge(
                        showBadge: value.userCart.length != 0 ? true : false,
                        badgeContent: Text(value.userCart.length.toString()),
                        badgeStyle: Badges.BadgeStyle(badgeColor: lightgreen),
                        badgeAnimation:
                            Badges.BadgeAnimation.fade(toAnimate: false),
                        child: //cart icon
                            GestureDetector(
                          onTap: goToCartPage,
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: black,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 20,
                      )
                    ],
                  )
                ],
              ),
              extendBody: true,

              //body
              body: Column(
                children: [
                  Container(
                    height: 60,
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: widget.selectedIndex == index
                                      ? back[index]
                                      : Colors.transparent,
                                  borderRadius: curve,
                                  border: Border.all(
                                      color: widget.selectedIndex == index
                                          ? Colors.grey.shade700
                                          : Colors.grey)),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              child: Text(
                                titleName[index],
                                style: TextStyle(
                                    color: widget.selectedIndex == index
                                        ? Colors.black
                                        : Colors.black),
                              ),
                            ),
                          );
                        }),
                  ),

                  //builder
                  Builder(builder: (context) {
                    //bakery
                    if (widget.selectedIndex == 0) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: value.bakeryList.length,
                              itemBuilder: (context, index) {
                                Product item = value.bakeryList[index];
                                int existing = value.userCart.indexWhere(
                                    (items) => items.name == item.name);
                                return bakeryTile(
                                  item: value.bakeryList[index],
                                  add: () => addTocart(item),
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
                                            Provider.of<Products>(context,
                                                    listen: false)
                                                .removeFromLikeList(item);
                                            item.isLiked = false;
                                          } else {
                                            Provider.of<Products>(context,
                                                    listen: false)
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
                                          size: 20,
                                          color:
                                              item.isLiked ? Colors.red : null,
                                        ),
                                      )),
                                );
                              }));
                    }

                    //fruits
                    if (widget.selectedIndex == 1) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: value.fruitList.length,
                            itemBuilder: ((context, index) {
                              Product item = value.fruitList[index];
                              int existing = value.userCart.indexWhere(
                                  (items) => items.name == item.name);

                              return bakeryTile(
                                item: value.fruitList[index],
                                add: () => addTocart(item),
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
                                          Provider.of<Products>(context,
                                                  listen: false)
                                              .removeFromLikeList(item);
                                          item.isLiked = false;
                                        } else {
                                          Provider.of<Products>(context,
                                                  listen: false)
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
                                        size: 20,
                                        color: item.isLiked ? Colors.red : null,
                                      ),
                                    )),
                              );
                            })),
                      );
                    }

                    //vegetables
                    if (widget.selectedIndex == 2) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: value.vegetableList.length,
                            itemBuilder: ((context, index) {
                              Product item = value.vegetableList[index];
                              int existing = value.userCart.indexWhere(
                                  (items) => items.name == item.name);

                              return bakeryTile(
                                item: value.vegetableList[index],
                                add: () => addTocart(item),
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
                                          Provider.of<Products>(context,
                                                  listen: false)
                                              .removeFromLikeList(item);
                                          item.isLiked = false;
                                        } else {
                                          Provider.of<Products>(context,
                                                  listen: false)
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
                                        size: 20,
                                        color: item.isLiked ? Colors.red : null,
                                      ),
                                    )),
                              );
                            })),
                      );
                    }

                    //drinks
                    else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: value.drinkList.length,
                            itemBuilder: ((context, index) {
                              Product item = value.drinkList[index];
                              int existing = value.userCart.indexWhere(
                                  (items) => items.name == item.name);

                              return bakeryTile(
                                item: value.drinkList[index],
                                add: () => addTocart(item),
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
                                          Provider.of<Products>(context,
                                                  listen: false)
                                              .removeFromLikeList(item);
                                          item.isLiked = false;
                                        } else {
                                          Provider.of<Products>(context,
                                                  listen: false)
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
                                        size: 20,
                                        color: item.isLiked ? Colors.red : null,
                                      ),
                                    )),
                              );
                            })),
                      );
                    }
                  })
                ],
              ),
            )));
  }
}
