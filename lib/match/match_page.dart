import 'package:fantagita/match/home_page.dart';
import 'package:fantagita/match/start_match_page.dart';
import 'package:fantagita/match/start_squad_choose_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';
import 'choose_squad_page.dart';

class MatchPage extends StatefulWidget {
  final User? user;
  final Function(int) changePage;
  const MatchPage({super.key, required this.user, required this.changePage});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final database = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(shrinkWrap: true, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StreamBuilder<Object>(
                  stream: database.isStarted(),
                  builder: (context, isStarted) {
                    return FutureBuilder(
                        future: database.isAdmin(),
                        builder: (context, isAdmin) {
                          if (isStarted.hasData && isStarted.data == 1) {
                            if (isAdmin.hasData && isAdmin.data == true) {
                              return StartMatchPage(
                                  changePage: widget.changePage);
                            }
                            return StreamBuilder<Object>(
                                stream: database.getSquadStream(),
                                builder: (context, chooseSquadSnapshot) {
                                  if (chooseSquadSnapshot.hasData &&
                                      chooseSquadSnapshot.data == true) {
                                    return const Text(
                                      "Attendi che l'admin avvii la partita...",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                  return const ChooseSquadPage();
                                });
                          } else if (isStarted.hasData && isStarted.data == 2) {
                            return const HomePage();
                          }

                          if (isAdmin.hasData && isAdmin.data == true) {
                            return StartSquadChoosePage(
                                changePage: widget.changePage);
                          }
                          return const Text(
                            "Attendi che l'admin avvii la partita...",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          );
                        });
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
