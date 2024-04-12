import 'package:fantagita/Auth/auth_page.dart';
import 'package:fantagita/custom%20components/button.dart';
import 'package:fantagita/custom%20components/container_card.dart';
import 'package:fantagita/pages/home_page.dart';
import 'package:flutter/material.dart';
class info_page extends StatefulWidget {
  const info_page({super.key});

  @override
  State<info_page> createState() => _info_pageState();
}

class _info_pageState extends State<info_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff303030),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("assets/images/logo.png"),
                      width: 200,

                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      "0.0.1",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    CustomContainerCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Creata da Luca Luisi e Marco Caputo",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              onPressed: (){

                              },
                              child: const Icon(Icons.add),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    CustomContainerCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Da una idea di Simona Iannuzzi",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
