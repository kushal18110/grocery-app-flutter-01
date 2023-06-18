import 'package:flutter/material.dart';
import 'package:grocery_app/colos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/services/google.dart';

import 'register-page.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {

  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //sign user funtion
  void signUserIn() async {
    //loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //signing method
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pop(context);
    
    } 
    //catching errors
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        return wrongUser();
      }
      if (e.code == 'wrong-password') {
        return wrongPassword();
      }
    }
  }

  //wrong user funtion
  void wrongUser() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('User not found \nplease try again'),
          );
        });
  }

  //wrong user funtion
  void wrongPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Wrong password \nplease try again'),
          );
        });
  }

  //to register page
  void toRegisterPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const RegisterPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),

          //lock icon
          const Icon(
            Icons.lock,
            size: 80,
          ),

          //email text field
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 60),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6)),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                //hint text
                hintText: 'email',

                //prefix icon
                prefixIcon: const Icon(Icons.mail_outline),
                prefixIconColor: Colors.grey,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                focusedBorder: const OutlineInputBorder(),
              ),
            ),
          ),

          //password text field
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6)),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                //hint text
                hintText: 'password',

                //prefix icon
                prefixIcon: const Icon(Icons.key),

                //suffix icon
                suffixIcon: const Icon(Icons.remove_red_eye),
                prefixIconColor: Colors.grey,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                focusedBorder: const OutlineInputBorder(),
              ),
            ),
          ),

          //forgot password
          Container(
            margin: const EdgeInsets.only(right: 20, top: 5),
            child: Text(
              'Forgot Password ?',
              style: TextStyle(
                  color: Colors.blue[300], fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ),

          //signin buttton
          GestureDetector(
            onTap: signUserIn,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12)),
              child: const Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          //divider
          const Row(
            children: [
              Expanded(
                  child: Divider(
                thickness: 2,
                indent: 2,
                endIndent: 4,
              )),
              Text('Or continue with'),
              Expanded(child: Divider(thickness: 2, indent: 4, endIndent: 2)),
            ],
          ),

          const SizedBox(
            height: 40,
          ),

          //google and apple sign in
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => goggleService().googleSignIn(),
                    child: 

                    //google logo
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white),
                      ),
                      padding: const EdgeInsets.all(10),
                      height: 65,
                      width: 65,
                      child: Center(
                        child: Image.asset('lib/images/google.png'),
                      ),
                    ),
                  ),

                  //apple logo
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    padding: const EdgeInsets.all(10),
                    height: 65,
                    width: 65,
                    child: Center(
                      child: Image.asset('lib/images/apple-logo.png'),
                    ),
                  ),
                ],
              ),

              //register text
              Container(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dont\'t have an account ? '),

                    //register function
                    GestureDetector(
                        onTap: toRegisterPage,
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
