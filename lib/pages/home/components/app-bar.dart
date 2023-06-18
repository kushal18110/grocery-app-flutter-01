import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as Badges;
import '../cart-page.dart';

class MyappBar extends StatelessWidget implements PreferredSizeWidget {
  const MyappBar({super.key});

  @override
  Widget build(BuildContext context) {
    void goToCartPage() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return cartPage();
      }));
    }

    return Consumer<Products>(builder: (context, value, child) {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.menu,
            size: 30,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          Row(
            children: [
              //badge
              Badges.Badge(
                showBadge: value.userCart.length != 0 ? true : false,
                badgeContent: Text(value.userCart.length.toString()),
                badgeStyle: Badges.BadgeStyle(badgeColor: lightgreen),
                badgeAnimation: Badges.BadgeAnimation.fade(toAnimate: false),
                child: //cart icon
                    GestureDetector(
                  onTap: goToCartPage,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: black,
                  ),
                ),
              ),

              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
      );
    });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
