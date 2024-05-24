import 'package:fantagita/custom%20components/button.dart';
import 'package:fantagita/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';

class ChooseSquadPage extends StatefulWidget {
  const ChooseSquadPage({super.key});

  @override
  State<ChooseSquadPage> createState() => _ChooseSquadPageState();
}

class _ChooseSquadPageState extends State<ChooseSquadPage> {
  final database = Database();
  Map<String, bool>? values;
  int panini = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "Scegli la tua squadra",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$panini ",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Icon(Icons.lunch_dining),
          ],
        ),
        FutureBuilder(
          future: database.getUidsInMatchList(),
          builder: (context,
              AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (values == null && snapshot.hasData) {
                snapshot.data?.remove(Authentication().user?.uid);
                values = snapshot.data?.map((String key, value) {
                  return MapEntry(key, false);
                });
              }
              return Column(
                  children: values!.keys.map((String key) {
                return FutureBuilder(
                  future: database.getUsername(key),
                  builder: (context, AsyncSnapshot<String> snapshotUsername) {
                    return CheckboxListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshotUsername.data!),
                          Row(
                            children: [
                              Text("${snapshot.data?[key]?["price"]} "),
                              const Icon(Icons.lunch_dining),
                            ],
                          )
                        ],
                      ),
                      value: values?[key],
                      onChanged: (bool? value) {
                        setState(() {
                          values?[key] = value!;
                          panini = 100;
                          for (var entry in values!.entries) {
                            if (entry.value == true) {
                              print("1. ${snapshot.data?[entry.key]?["price"]}");
                              panini -=
                                  snapshot.data?[entry.key]?["price"] as int;
                            }
                            if (panini < 0) {
                              values?[entry.key] = false;
                              print("2. ${snapshot.data?[entry.key]?["price"]}");
                              panini +=
                                  snapshot.data?[entry.key]?["price"] as int;
                            }
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  },
                );
              }).toList());
            }
          },
        ),
        CustomButton(
            onPressed: () {
              List<String> keysWithTrueValues = values!.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList();
              if (keysWithTrueValues.length == 4) {
                database.setSquad(keysWithTrueValues);
              } else {
                print("Devi selezionare 4 studenti");
              }
            },
            child: const Text(
              "Vai!",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
