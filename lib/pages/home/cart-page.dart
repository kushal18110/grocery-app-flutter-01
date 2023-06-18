import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:grocery_app/models/product-model.dart';
import 'package:grocery_app/pages/home/components/cart-tile.dart';
import 'package:provider/provider.dart';


class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {


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

    return Consumer<Products>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Your Cart',
                      style: TextStyle(fontSize: 27),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: value.userCart.length,
                          itemBuilder: (context, index) {
                            Product eachItem = value.userCart[index];
                            return cartTile(
                              item: eachItem,
                              add: () => addTocart(eachItem),
                              remove: () => removeFromCart(eachItem),
                              text: eachItem.quantity.toString(),
                            );
                          })),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(color: lightgrey, borderRadius: curve),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total price',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$' + value.calculateTotal(),
                              style: const TextStyle(fontSize: 23),
                            ),
                          ],
                        ),
                        Builder(builder: (context) {
                          if (value.calculateTotal() == '0.00') {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: lightgreen, borderRadius: curve),
                              child: const Text(
                                'no items',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: (){
                                Provider.of<Products>(context, listen: false).checkOut();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: lightgreen, borderRadius: curve),
                                child: const Text(
                                  'Checkout',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            );
                          }
                        })
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
