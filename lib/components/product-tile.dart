import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/models/product-model.dart';

class productTile extends StatelessWidget {
  const productTile({super.key, required this.product, required this.onTap, required this.remove, required this.icon});
  final Product product;
  final void Function()? onTap;
  final void Function()? remove;
  final Widget icon;
  @override
  Widget build(BuildContext context) {


    return Container(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: product.backColor, borderRadius: curve),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //product image
              Container(
                height: 55,
                width: 55,
                child: Image.asset(product.imgPath),
              ),
              const SizedBox(
                height: 15,
              ),

              //product name and price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$' + product.price,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [

                  //add to cart icon
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(12))),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),

                  //remove from cart icon
                  GestureDetector(
                    onTap: remove,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                      ),
                    ),
                  )
                ],
              ),

              //like products icon
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                padding: const EdgeInsets.all(6),
                child: icon,
              )
            ],
          )
        ],
      ),
    );
  }
}
