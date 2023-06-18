import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/models/product-model.dart';

class bakeryTile extends StatelessWidget {
  const bakeryTile(
      {super.key,
      required this.item,
      required this.add,
      required this.remove,
      required this.icon});
  final Product item;
  final void Function()? add;
  final void Function()? remove;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 280,
      margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(color: item.backColor, borderRadius: curve),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //image
              Container(
                height: 40,
                width: 40,
                child: Image.asset(item.imgPath),
              ),

              SizedBox(
                width: 10,
              ),

              //name and price
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(fontSize: 13),
                      ),

                      SizedBox(
                        width: 7,
                      ),

                      //like icon
                      Container(height: 20, width: 20, child: icon)
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$' + item.price,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //add to cart
              GestureDetector(
                  onTap: add,
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Icon(
                        Icons.add,
                        size: 20,
                      ))),

              SizedBox(
                width: 3,
              ),

              //remove from cart
              GestureDetector(
                onTap: remove,
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
