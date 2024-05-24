import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'auth_service.dart';

class Database {
  late User? user;
  final instance = FirebaseFirestore.instance;

  Database() {
    final auth = Authentication();
    user = auth.user;
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
      "started": 0,
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
          .update({"started": match["started"] + 1});
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
      users[user!.uid] = {"pt": 0, "squad": [], "price": 25};
      await instance.collection("matches").doc(code).update({"users": users});
    } else {
      print("---------------- Errore: il match $code non esiste");
    }
  }

  Future<void> setSquad(List<String> squad) async {
    DocumentSnapshot match = await getMatchData();
    String matchCode = await getMatchCode();
    Map<String, dynamic> users = match['users'];
    users[user!.uid]["squad"] = squad;
    await instance
        .collection("matches")
        .doc(matchCode)
        .update({"users": users});
  }

  Future<void> setPrice(String uid, int newPrice) async {
    DocumentSnapshot match = await getMatchData();
    String matchCode = await getMatchCode();
    Map<String, dynamic> users = match['users'];
    users[uid]['price'] = newPrice;
    await instance
        .collection("matches")
        .doc(matchCode)
        .update({"users": users});
  }

  Stream<int> isStarted() async* {
    String matchCode = await getMatchCode();
    yield* instance
        .collection("matches")
        .doc(matchCode)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        var data = snapshot.data() as Map<String, dynamic>;
        return data["started"] as int? ?? 0;
      }
      return 0;
    });
  }

  Stream<bool> getSquadStream() async* {
    String matchCode = await getMatchCode();
    yield* instance.collection("matches").doc(matchCode).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data()?["users"][user?.uid]["squad"].length == 4) {
        return true;
      }
      return false;
    });
  }

  Future<String> getUsername(String uid) async {
    DocumentSnapshot user = await instance.collection("users").doc(uid).get();
    return user["name"];
  }

  Future<String> getMatchCode() async {
    DocumentSnapshot userDetails = await getUserData();
    return userDetails["match"];
  }

  int getPoints(Map<String, Map<String, dynamic>> data, String uid) {
    int result = 0;
    List squad = data[uid]?["squad"];
    for (String player in squad) {
      result += data[player]?["pt"] as int;
    }
    return result;
  }

  Future<Map<String, Map<String, dynamic>>> getUidsInMatchList() async {
    DocumentSnapshot match = await getMatchData();
    Map<String, Map<String, dynamic>> data = {};
    for (var entry in match['users'].entries) {
      data[entry.key] = entry.value;
    }
    List<MapEntry<String, Map<String, dynamic>>> entries =
        data.entries.toList();
    entries.sort((a, b) => getPoints(data, b.key).compareTo(getPoints(data, a.key)));
    Map<String, Map<String, dynamic>> sortedMap =
        LinkedHashMap.fromEntries(entries);

    return sortedMap;
  }

  Future<Map<String, Map<String, dynamic>>> getUsersInMatchList() async {
    Map<String, Map<String, dynamic>> data = await getUidsInMatchList();

    for (var entry in data.entries) {
      String username = await getUsername(entry.key);
      data[entry.key]?["username"] = username;
    }

    return data;
  }

  Stream<DocumentSnapshot> getMatchSnapshots() async* {
    String matchCode = await getMatchCode();
    yield* instance.collection("matches").doc(matchCode).snapshots();
  }

  Future<DocumentSnapshot> getMatchData() async {
    String matchCode = await getMatchCode();
    return instance.collection("matches").doc(matchCode).get();
  }

  Future<DocumentSnapshot> getUserData() async {
    return instance.collection("users").doc(user?.uid).get();
  }

  Future<bool> isAdmin() async {
    return (await getUserData())["admin"];
  }
}
