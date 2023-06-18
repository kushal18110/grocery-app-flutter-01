import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/models/product-model.dart';

class likeTile extends StatelessWidget {
  const likeTile(
      {super.key,
      required this.item,
      required this.add,
      required this.remove,
      required this.onSelected});
  final Product item;
  final void Function()? add;
  final void Function()? remove;
  final void Function(String)? onSelected;

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(fontSize: 16),
                      ),

                      SizedBox(
                        width: 7,
                      ),

                      // //like icon
                      // Container(height: 20, width: 20, child: icon)

                      Container(
                        height: 20,
                        width: 20,
                        child: PopupMenuButton(
                            splashRadius: 1,
                            padding: EdgeInsets.all(0),
                            offset: Offset(10, 20),
                            icon: Icon(Icons.more_horiz),
                            onSelected: onSelected,
                            itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    height: 15,
                                    child: Text('remove'),
                                    value: 'remove',
                                  )
                                ]),
                      )
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
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.add,
                        size: 20,
                      ))),

              SizedBox(
                width: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
