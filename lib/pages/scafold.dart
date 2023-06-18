import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:grocery_app/pages/home/cart-page.dart';
import 'package:grocery_app/pages/home/home-page.dart';
import 'package:grocery_app/pages/profile-tab/profile-page.dart';
import 'package:provider/provider.dart';
import 'like-tab/likes-page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //pages
  List<Widget> pages = [
    const HomeTab(),
    const likePage(),
    const cartPage(),
    const profilePage(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //bottom nav bar
        bottomNavigationBar:
            Consumer<Products>(builder: (context, value, child) {
          return GNav(
              backgroundColor: const Color(0xFF86cb86),
              activeColor: Colors.white,
              color: Colors.white,
              tabBackgroundColor: Colors.white,
              padding: const EdgeInsets.all(6),
              tabMargin: const EdgeInsets.all(20),
              tabBorderRadius: 12,
              duration: const Duration(milliseconds: 250),
              selectedIndex: 0,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },

              //tabs
              tabs: [
                const GButton(
                  icon: Icons.home,
                  text: 'Home',
                  textStyle: TextStyle(fontWeight: FontWeight.normal),
                  textColor: Colors.black,
                  iconColor: Colors.white,
                  iconActiveColor: Color(0xFF86cb86),
                ),
                const GButton(
                  icon: Icons.favorite_border,
                  text: 'Liked',
                  textStyle: TextStyle(fontWeight: FontWeight.normal),
                  textColor: Colors.black,
                  iconColor: Colors.white,
                  iconActiveColor: Color(0xFF86cb86),
                ),
                const GButton(
                  icon: Icons.shopping_bag_outlined,
                  text: 'Cart',
                  textStyle: TextStyle(fontWeight: FontWeight.normal),
                  textColor: Colors.black,
                  iconColor: Colors.white,
                  iconActiveColor: Color(0xFF86cb86),
                ),
                const GButton(
                  icon: Icons.account_circle_outlined,
                  text: 'Profile',
                  textStyle: TextStyle(fontWeight: FontWeight.normal),
                  textColor: Colors.black,
                  iconColor: Colors.white,
                  iconActiveColor: Color(0xFF86cb86),
                ),
              ]);
        }),
        //body
        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ));
  }
}
