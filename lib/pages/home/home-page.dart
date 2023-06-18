import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/components/category-list.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:grocery_app/pages/all-products-page.dart';
import 'package:grocery_app/pages/home/category-layout.dart';
import 'package:grocery_app/pages/home/components/app-bar.dart';
import 'package:grocery_app/pages/home/components/bakery/bakery-layout.dart';
import 'package:grocery_app/pages/home/components/drinks/drinks-layout.dart';
import 'package:grocery_app/pages/home/components/fruits/fruit-layout.dart';
import 'package:grocery_app/pages/home/components/vegetables/veegetable-layout.dart';
import 'package:grocery_app/pages/home/top-products-layout.dart';
import 'package:provider/provider.dart';
import 'cart-page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //future load content function
  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  void goToCartPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const cartPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyappBar(),
        body: FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    //category consumer
                    Consumer<CategoryList>(
                        builder: ((context, value, child) => Column(
                              children: [
                                //categories section
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Categories',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: curve),
                                          child: Text(
                                            'Explore All',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[660]),
                                          )),
                                    ],
                                  ),
                                ),

                                //categories
                                Container(
                                    padding: const EdgeInsets.all(20),
                                    child: const categoryLayout()),
                              ],
                            ))),

                    const SizedBox(
                      height: 10,
                    ),

                    //top products section
                    Consumer<Products>(
                        builder: (context, value, child) => Column(
                              children: [
                                //top products title
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Top Products',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: curve),
                                          child: Text(
                                            'Explore All',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[660]),
                                          )),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                //product list view
                                Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: const TopProducts())
                              ],
                            )),

                    const SizedBox(
                      height: 20,
                    ),

                    //bakery home category
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Bakery',
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return allProducts(selectedIndex: 0);
                              }));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: curve),
                                child: Text(
                                  'Explore All',
                                  style: TextStyle(
                                      color: Colors.grey[660], fontSize: 12),
                                )),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //bakery layout
                    Consumer<Products>(
                      builder: (context, value, child) => const myBakery(),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //fruits home category
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Fruits',
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return allProducts(selectedIndex: 1);
                              }));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: curve),
                                child: Text(
                                  'Explore All',
                                  style: TextStyle(
                                      color: Colors.grey[660], fontSize: 12),
                                )),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //fruit layout
                    Consumer<Products>(
                      builder: (context, value, child) => const myFruits(),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //vegetables home category
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Vegetables',
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return allProducts(selectedIndex: 2);
                              }));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: curve),
                                child: Text(
                                  'Explore All',
                                  style: TextStyle(
                                      color: Colors.grey[660], fontSize: 12),
                                )),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //vegetable layout
                    Consumer<Products>(
                      builder: (context, value, child) => const myVegetables(),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //drinks
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Drinks',
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return allProducts(selectedIndex: 3);
                              }));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: curve),
                                child: Text(
                                  'Explore All',
                                  style: TextStyle(
                                      color: Colors.grey[660], fontSize: 12),
                                )),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //vegetable layout
                    Consumer<Products>(
                      builder: (context, value, child) => const myDrinks(),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }
            }));
  }
}
