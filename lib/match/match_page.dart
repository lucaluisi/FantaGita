import 'package:fantagita/custom%20components/account_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  final User? user;
  const MatchPage({super.key, required this.user});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/images/title.png"),
          width: 230.0,
        ),
        centerTitle: true,
        toolbarHeight: 70,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: AccountCard(user: widget.user)),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  ],
                ),
              ),
            )),
      ),
    );
  }
}
