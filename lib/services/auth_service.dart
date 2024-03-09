import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google sing in
  singInWhithGoogle() async{
    //begin interactive sing in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtaiin auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // craete a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken:  gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finnaly, let's sing in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}