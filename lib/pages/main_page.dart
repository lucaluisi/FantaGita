import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantagita/Auth/auth_page.dart';
import 'package:fantagita/custom%20components/button.dart';
import 'package:fantagita/pages/prematch_page.dart';
import 'package:fantagita/pages/regulation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'navigator_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.displayName != null) {
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data?.uid)
                  .snapshots(),
              builder: (context, snapshotMatch) {
                if (snapshotMatch.hasData &&
                    snapshotMatch.data?.data()?["match"] != null) {
                  return NavigatorPage(user: snapshot.data);
                }
                return PrematchPage(user: snapshot.data);
              });
        } else {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(image: AssetImage("assets/images/title.png")),
                  const SizedBox(height: 60),
                  const Text(
                    "FantaGita, un fantasy game student-made sulla gita di classe",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const AuthPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(5.0, 0);
                            const end = Offset.zero;
                            const curve = Curves.ease;
                            final tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            final offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Gioca",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                              const RegulationPage(),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                const begin = Offset(5.0, 0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                final tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                final offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                        color: Theme.of(context).colorScheme.secondary,
                        child: const Icon(
                          Icons.article,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      CustomButton(
                        onPressed: () {},
                        padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                        color: Theme.of(context).colorScheme.secondary,
                        child: const Icon(
                          Icons.quiz,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
