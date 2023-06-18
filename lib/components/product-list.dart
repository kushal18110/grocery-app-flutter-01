import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:grocery_app/models/product-model.dart';

class Products extends ChangeNotifier {
  //fruits list
  final List<Product> fruitList = [
    Product(
        name: 'Kiwi Fruit',
        price: '2.50',
        imgPath: 'lib/images/kiwi.png',
        backColor: lightblue,
        isLiked: false),
    Product(
      name: 'Wtermelon',
      price: '1.50',
      imgPath: 'lib/images/watermelon.png',
      backColor: lightgreen,
      isLiked: false,
    ),
    Product(
      name: 'Strawberry',
      price: '1.20',
      imgPath: 'lib/images/strawberry.png',
      backColor: lightorange,
      isLiked: false,
    ),
    Product(
      name: 'Banana',
      price: '0.49',
      imgPath: 'lib/images/banana.png',
      backColor: lightorange,
      isLiked: false,
    ),
    Product(
      name: 'Orange',
      price: '0.79',
      imgPath: 'lib/images/orange.png',
      backColor: lightgreen,
      isLiked: false,
    ),
    Product(
      name: 'Blue Berry',
      price: '3.20',
      imgPath: 'lib/images/blueberry.png',
      backColor: lightpurple,
      isLiked: false,
    ),
  ];

  //bakery item list
  final List<Product> bakeryList = [
    Product(
      name: 'Croissant',
      price: '2.50',
      imgPath: 'lib/images/croissant.png',
      backColor: lightgreen,
      isLiked: false,
    ),
    Product(
      name: 'Cookie',
      price: '1.00',
      imgPath: 'lib/images/cookie.png',
      backColor: lightorange,
      isLiked: false,
    ),
    Product(
      name: 'Baguette',
      price: '5.50',
      imgPath: 'lib/images/baguette.png',
      backColor: lightblue,
      isLiked: false,
    ),
    Product(
      name: 'Cake slice',
      price: '3.70',
      imgPath: 'lib/images/cake-slice.png',
      backColor: lightpink,
      isLiked: false,
    ),
    Product(
      name: 'Cupcake',
      price: '2.30',
      imgPath: 'lib/images/cupcake.png',
      backColor: lightpurple,
      isLiked: false,
    ),
    Product(
      name: 'Donut',
      price: '3.20',
      imgPath: 'lib/images/donut.png',
      backColor: lightyellow,
      isLiked: false,
    ),
  ];

  //vegetable item list
  final List<Product> vegetableList = [
    Product(
        name: 'Carrot',
        price: '1.29',
        imgPath: 'lib/images/carrot.png',
        isLiked: false,
        backColor: lightyellow),
    Product(
        name: 'Broccoli',
        price: '1.99',
        isLiked: false,
        imgPath: 'lib/images/broccoli.png',
        backColor: lightblue),
    Product(
        name: 'Corn',
        price: '1.50',
        isLiked: false,
        imgPath: 'lib/images/corn.png',
        backColor: lightgreen),
    Product(
        name: 'Pear',
        price: '1.49',
        isLiked: false,
        imgPath: 'lib/images/pear.png',
        backColor: lightorange),
    Product(
        name: 'Eggplant',
        price: '1.00',
        isLiked: false,
        imgPath: 'lib/images/eggplant.png',
        backColor: lightpurple),
    Product(
        name: 'tomato',
        price: '2.30',
        isLiked: false,
        imgPath: 'lib/images/tomato.png',
        backColor: lightpink),
  ];

  //drinks list
  final List<Product> drinkList = [
    Product(
        name: 'Cocktail',
        price: '5.60',
        imgPath: 'lib/images/cocktail-2.png',
        backColor: lightgreen,
        isLiked: false),
    Product(
        name: 'Apple Juice',
        price: '3.20',
        imgPath: 'lib/images/drink.png',
        backColor: lightblue,
        isLiked: false),
    Product(
        name: 'Orange Juice',
        price: '5.20',
        imgPath: 'lib/images/orange-juice.png',
        backColor: lightorange,
        isLiked: false),
    Product(
        name: 'Energy Drink',
        price: '4.30',
        imgPath: 'lib/images/energy-drink.png',
        backColor: lightyellow,
        isLiked: false),
  ];

  //liked list
  List<Product> likedList = [];

  //get liked list
  List<Product> get likedLists => likedList;

  //making lists avalable
  List<Product> get fruitsList => fruitList;
  List<Product> get bakerylists => bakeryList;
  List<Product> get vegetablelists => vegetableList;
  List<Product> get drinkLists => drinkList;

  //user cart
  List<Product> _userCart = [];

  //get user cart
  List<Product> get userCart => _userCart;

  //add item to cart
  void addToCart(Product product) {
    int existingIndex =
        _userCart.indexWhere((item) => item.name == product.name);
    if (existingIndex != -1) {
      _userCart[existingIndex].quantity++;
      notifyListeners();
    } else {
      _userCart.add(product);
      notifyListeners();
    }

 
  }

  //remove from cart
  void removeFromCart(Product product) {
    int existingIndex =
        _userCart.indexWhere((item) => item.name == product.name);
    if (existingIndex != -1) {
      if (_userCart[existingIndex].quantity > 1) {
        _userCart[existingIndex].quantity--;
        notifyListeners();
      } else {
        _userCart.removeAt(existingIndex);
        notifyListeners();
      }
    }
  }

  //add to like list
  void addToLikeList(Product product) {
    likedList.add(product);
    notifyListeners();
  }

  //remove from like list
  void removeFromLikeList(Product product) {
    likedList.remove(product);
    product.isLiked = false;
    notifyListeners();
  }

  //total price
  String calculateTotal() {
    double totalPrice = 0.0;
    for (int i = 0; i < userCart.length; i++) {
      totalPrice += double.parse(userCart[i].price) *
          double.parse(userCart[i].quantity.toString());
    }

    return totalPrice.toStringAsFixed(2);
  }

  //checkout
  List<Product> cartData = [];

  void checkOut() {
    cartData.addAll(userCart);

    print(cartData);
  }
}
