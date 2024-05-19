import 'package:fantagita/custom%20components/button.dart';
import 'package:fantagita/custom%20components/container_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  _launchInstagram(var nativeUrl, var webUrl) async {
    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipPath(
                  clipper: const ShapeBorderClipper(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(70),
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: const Image(
                      image: AssetImage("assets/images/logo.png"),
                      width: 200,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "0.0.1",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                onPressed: () {
                                  _launchInstagram(
                                      "instagram://user?username=marco_caputo06",
                                      "https://www.instagram.com/marco_caputo06");
                                },
                                color: Colors.white,
                                child: const Image(
                                  image:
                                      AssetImage("assets/images/instagram.png"),
                                  width: 100,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              CustomButton(
                                onPressed: () {
                                  _launchInstagram(
                                      "instagram://user?username=_lucaluisi_",
                                      "https://www.instagram.com/_lucaluisi_");
                                },
                                color: Colors.white,
                                child: const Image(
                                  image: AssetImage("assets/images/instagram.png"),
                                  width: 100,
                                  height: 20,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomContainerCard(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
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
        )),
      ),
    );
  }
}
