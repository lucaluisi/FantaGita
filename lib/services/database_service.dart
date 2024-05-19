import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'auth_service.dart';

class Database {
  late User? user;
  late Stream<DocumentSnapshot> userDetails;
  final instance = FirebaseFirestore.instance;

  Database() {
    final auth = Authentication();
    user = auth.user;
    userDetails = instance.collection("users").doc(user?.uid).snapshots();
  }

  Future<void> saveUser(User? user) async {
    await instance.collection("users").doc(user?.uid).set({
      "email": user?.email,
      "name": user?.displayName,
      "profilepic": user?.photoURL,
      "uid": user?.uid,
      "match": null,
      "admin": false,
    });
  }

  Future<void> addUserData(data) async {
    await instance.collection("users").doc(user?.uid).update(data);
  }

  Future<void> createMatch(
      String name, String startDate, String endDate) async {
    String matchUuid = const Uuid().v4();
    addUserData({
      "match": matchUuid,
      "admin": true,
    });
    await instance.collection("matches").doc(matchUuid).set({
      "admin": user?.uid,
      "name": name,
      "startDate": startDate,
      "endDate": endDate,
      "started": false,
      "users": {},
    });
  }

  Future<void> startMatch() async {
    String matchCode = await getMatchCode();
    DocumentSnapshot match =
        await instance.collection("matches").doc(matchCode).get();
    if (match.exists) {
      await instance
          .collection("matches")
          .doc(matchCode)
          .update({"started": true});
    } else {
      print("---------------- Errore: il match $matchCode non esiste");
    }
  }

  Future<void> enterMatch(String code) async {
    DocumentSnapshot match =
        await instance.collection("matches").doc(code).get();
    if (match.exists) {
      addUserData({
        "match": code,
      });
      Map<String, dynamic> users = match['users'];
      users[user!.uid] = 0;
      await instance.collection("matches").doc(code).update({"users": users});
    } else {
      print("---------------- Errore: il match $code non esiste");
    }
  }

  Stream<bool> isStarted() async* {
    DocumentSnapshot matchCode =
        await instance.collection("users").doc(user?.uid).get();
    yield* instance
        .collection("matches")
        .doc(matchCode['match'])
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        var data = snapshot.data() as Map<String, dynamic>;
        return data["started"] as bool? ?? false;
      }
      return false;
    });
  }

  Stream<bool> isAdmin() async* {
    yield* userDetails.map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        var data = snapshot.data() as Map<String, dynamic>;
        return data["admin"] as bool? ?? false;
      }
      return false;
    });
  }

  Future<String> getUsername(String uid) async {
    DocumentSnapshot user = await instance.collection("users").doc(uid).get();
    return user["name"];
  }

  Future<String> getMatchCode() async {
    DocumentSnapshot userDetails =
        await instance.collection("users").doc(user?.uid).get();
    return userDetails["match"];
  }

  Future<Map<String, int>> getUsersInMatchList() async {
    String matchCode = await getMatchCode();
    DocumentSnapshot match =
        await instance.collection("matches").doc(matchCode).get();
    Map<String, int> data = {};
    for (var entry in match['users'].entries) {
      String username = await getUsername(entry.key);
      data[username] = entry.value;
    }

    List<MapEntry<String, int>> entries = data.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    Map<String, int> sortedMap = LinkedHashMap.fromEntries(entries);

    return sortedMap;
  }

  Stream<DocumentSnapshot> getMatchSnapshots() async* {
    String matchCode = await getMatchCode();
    yield* instance.collection("matches").doc(matchCode).snapshots();
  }
}
