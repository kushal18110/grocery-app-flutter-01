import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/pages/auth/auth-page.dart';
import '../scafold.dart';

class CheckingPage extends StatefulWidget {
  const CheckingPage({super.key});

  @override
  State<CheckingPage> createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return AuthPage();
        }
      },
    );
  }
}
