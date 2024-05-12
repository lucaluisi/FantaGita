import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'auth_service.dart';

class Database {

  Future<void> saveUser(User? user) async {
    FirebaseFirestore.instance.collection("users")
      .doc(user?.email)
      .set({
        "email": user?.email,
        "name": user?.displayName,
        "profilepic": user?.photoURL,
        "uid": user?.uid,
        "match": null,
      }
    );
  }

  Future<void> addUserData(User? user, data) async {
    FirebaseFirestore.instance.collection("users")
      .doc(user?.email)
      .update(data);
  }

  Future<void> createMatch(String name, String startDate, String endDate) async {
    String match_uuid = Uuid().v4();
    Database().addUserData(Authentication().user, {
      "match": match_uuid,
    });
    FirebaseFirestore.instance.collection("matches")
      .doc(match_uuid)
      .set({
      match_uuid: {
          "admin": Authentication().user?.uid,
          "name": name,
          "startDate": startDate,
          "endDate": endDate,
        }
      }
    );
  }
}