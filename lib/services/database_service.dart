import 'package:firebase_database/firebase_database.dart';

class Database {

  DatabaseReference ref = FirebaseDatabase.instance.ref("matches");

  write (value) async {
    await ref.update(value);
  }
}