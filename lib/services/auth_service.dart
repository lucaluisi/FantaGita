import 'package:fantagita/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim());

    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> signUp(String username, String email, String password) async {
    final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim());
    User? us = auth.user;
    await us?.updateDisplayName(username.trim());

    user = FirebaseAuth.instance.currentUser;

    await Database().saveUser(user);
  }
}