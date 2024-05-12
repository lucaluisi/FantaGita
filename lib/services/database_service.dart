import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'auth_service.dart';

class Database {
  Future<void> saveUser(User? user) async {
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
      "email": user?.email,
      "name": user?.displayName,
      "profilepic": user?.photoURL,
      "uid": user?.uid,
      "match": null,
    });
  }

  Future<void> addUserData(User? user, data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .update(data);
  }

  Future<void> createMatch(
      String name, String startDate, String endDate) async {
    String matchUuid = const Uuid().v4();
    Database().addUserData(Authentication().user, {
      "match": matchUuid,
    });
    await FirebaseFirestore.instance.collection("matches").doc(matchUuid).set({
      "admin": Authentication().user?.uid,
      "name": name,
      "startDate": startDate,
      "endDate": endDate,
      "users": {},
    });
  }

  Future<void> enterMatch(String code) async {
    DocumentSnapshot match = await FirebaseFirestore.instance.collection("matches").doc(code).get();
    if (match.exists) {
      Database().addUserData(Authentication().user, {
        "match": code,
      });
      Map<String, dynamic> users = match['users'];
      users[Authentication().user!.uid] = 0;
      await FirebaseFirestore.instance.collection("matches").doc(code).update(
          {"users": users});
    } else {
      print("---------------- Errore: il match $code non esiste");
    }
  }

  Future<String> getUsername(String uid) async {
    DocumentSnapshot user = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return user["name"];
  }

  Future<Map<String, int>> getUsersInMatchList(User? user) async {
    DocumentSnapshot userDetails = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    String matchUuid = userDetails["match"];
    DocumentSnapshot match = await FirebaseFirestore.instance
        .collection("matches")
        .doc(matchUuid)
        .get();
    Map<String, int> data = {};
    for (var entry in match['users'].entries) {
      String username = await getUsername(entry.key);
      data[username] = entry.value;
    }

    List<MapEntry<String, int>> entries = data.entries.toList();
    entries.sort((a, b) => a.value.compareTo(b.value));
    Map<String, int> sortedMap = LinkedHashMap.fromEntries(entries);

    return sortedMap;
  }
}
