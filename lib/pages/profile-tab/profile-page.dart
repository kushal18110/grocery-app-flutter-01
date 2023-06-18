import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    var photo = FirebaseAuth.instance.currentUser!.photoURL!;

    void logOut() {
      FirebaseAuth.instance.signOut();
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(photo),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.displayName!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: logOut,
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey.shade400))),
                      child: const ListTile(
                        title: Text('Logout'),
                        trailing: Icon(
                          Icons.logout_rounded,
                          color: Colors.red,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
