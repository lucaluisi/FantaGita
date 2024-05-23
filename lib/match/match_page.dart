import 'package:fantagita/match/home_page.dart';
import 'package:fantagita/match/start_match_page.dart';
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
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StreamBuilder<Object>(
                  stream: database.isStarted(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == 1) {
                      return const ChooseSquadPage();
                    } else if (snapshot.hasData && snapshot.data == 2) {
                      return const HomePage();
                    }
                    return FutureBuilder(
                        future: database.isAdmin(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data == true) {
                            return StartMatchPage(
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
