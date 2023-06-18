import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/components/category-list.dart';
import 'package:grocery_app/components/product-list.dart';
import 'package:grocery_app/pages/auth/checking-page.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  //initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //categories
        ChangeNotifierProvider(create: (context) => CategoryList()),

        //products
        ChangeNotifierProvider(create: (context) => Products()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CheckingPage(),
      ),
    );
  }
}
