import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class goggleService {
  googleSignIn() async {

    //get user info
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //authenticate user
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //get creditinals
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );


    return FirebaseAuth.instance.signInWithCredential(credential);
  }
}
