import 'package:fantagita/match/create_match_page.dart';
import 'package:fantagita/custom%20components/account_card.dart';
import 'package:fantagita/custom%20components/button.dart';
import 'package:fantagita/custom%20components/container_card.dart';
import 'package:fantagita/custom%20components/text_field.dart';
import 'package:fantagita/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrematchPage extends StatefulWidget {
  final User? user;
  const PrematchPage({super.key, required this.user});

  @override
  State<PrematchPage> createState() => _PrematchPageState();
}

class _PrematchPageState extends State<PrematchPage> {
  final _entryCodeController = TextEditingController();

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
                CustomContainerCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Crea partita",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                            color: Theme.of(context).colorScheme.onPrimary,
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const CreateMatchPage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(5.0, 0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;
                                    final tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    final offsetAnimation =
                                        animation.drive(tween);
                                    return SlideTransition(
                                        position: offsetAnimation,
                                        child: child);
                                  },
                                ),
                              );
                            },
                            child: const Icon(Icons.add))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomContainerCard(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Entra in una partita",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _entryCodeController,
                        hintText: "Codice",
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () => Database().enterMatch(_entryCodeController.text),
                        child: const Icon(
                          Icons.arrow_right_alt_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
