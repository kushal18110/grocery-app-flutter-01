import 'package:flutter/material.dart';
import 'package:grocery_app/pages/auth/auth-page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../colos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //register new user
  void registerUser() async {

    //loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //register user method

      if (_passwordController.text == _confirmPasswordController.text) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
          Navigator.pop(context);

        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);

          //invalid email
          if(e.code == 'invalid-email'){
            showDialog(context: context, builder: (context){
              return const AlertDialog(content: Text('invalid email \nplease try again'),);
            }); 
          }
        }
      }else{
        Navigator.pop(context);
        showDialog(context: context, builder: (context){
          return const AlertDialog(content: Text('password dont match \nplease try again'),);
        });
      }
    
    

    //store data
    storeData(_nameController.text, _emailController.text);


  }


  Future storeData(String name, String email) async{
    await FirebaseFirestore.instance.collection('users').add({
      'name':name,
      'email':email
    });
  }

 

  //to login page
  void toLoginPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AuthPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,

      //app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      //body
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),

          //lock icon
          const Icon(
            Icons.lock,
            size: 80,
          ),

          //name text field
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 60),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6)),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                //hint text
                hintText: 'name',

                //prefix icon
                prefixIcon: const Icon(Icons.account_circle_outlined),
                prefixIconColor: Colors.grey,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                focusedBorder: const OutlineInputBorder(),
              ),
            ),
          ),

          //email text field
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
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

          //confirm password text field
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6)),
            child: TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                //hint text
                hintText: 'confirm password',

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

          //signin buttton
          GestureDetector(
            onTap: registerUser,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12)),
              child: const Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          //register text

          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account ? '),

                //register function
                GestureDetector(
                    onTap: toLoginPage,
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
