import 'package:fantagita/Auth/auth_page.dart';
import 'package:fantagita/custom%20components/button.dart';
import 'package:fantagita/custom%20components/container_card.dart';
import 'package:fantagita/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher_string.dart';

class info_page extends StatefulWidget {
  const info_page({super.key});

  @override
  State<info_page> createState() => _info_pageState();
}

class _info_pageState extends State<info_page> {

  /*_openInstagram (data) async{
    String dt = data as String;
    bool isIstalled = await DeviceApps.isAppInstalled('com.android.chrome');
    print(isIstalled);

    List<Application> apps = await DeviceApps.getInstalledApplications(includeSystemApps: true);

    for (var i = 0; i < apps.length; i++){
      print(apps[i].appName);

    }     NON FUNZIONAAAAA */

    /*
    if (isIstalled != false){
      print('pippo2');
      AndroidIntent intent = AndroidIntent(
        action: "action_view",
      );
      await intent.launch();
    }
    else if(await canLaunchUrlString(dt)) {
      await launchUrlString(dt);
      print('pippo3');

    }
    else {
      throw 'non si lancia $dt';
    }*/
  }

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
                              Column(
                                children: [
                                  CustomButton(
                                    onPressed: () {_openInstagram('https://www.instagram.com/_lucaluisi_/?igsh=NGs3N2lrcjBzMjZl');},
                                    child: const Image(
                                      image:
                                          AssetImage("assets/images/apple.png"),
                                      width: 100,
                                      height: 20,
                                    ),
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 3),
                                  ]
                              ),
                              Column(
                                children: [
                                  CustomButton(
                                    onPressed: () {},
                                    child: const Image(
                                      image:
                                          AssetImage("assets/images/apple.png"),
                                      width: 100,
                                      height: 20,
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
        )),
      ),
    );
  }
}
