import 'package:fantagita/custom%20components/container_card.dart';
import 'package:fantagita/pages/info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatefulWidget {
  User? user;

  AccountCard({
    super.key,
    required this.user,
  });

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  final _overlayController = OverlayPortalController();

  Future _removeAds() async {
    print("ciao");
  }

  Future _shareApp() async {
    print("ciao");
  }

  Future _infoApp() async {
    Navigator.push(context, MaterialPageRoute<void>(builder: (context) => const info_page()));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _overlayController.toggle,
      alignment: Alignment.center,
      color: Colors.white,
      icon: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomContainerCard(
                  color: Theme.of(context).colorScheme.background,
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: _overlayController.toggle,
                              icon: const Icon(Icons.close),
                            ),
                            const Image(
                              image: AssetImage("assets/images/title.png"),
                              width: 170.0,
                            ),
                            const IconButton(
                              onPressed: null,
                              icon: Icon(null),
                            ),
                          ],
                        ),
                      ),
                      CustomContainerCard(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: widget.user?.photoURL != null
                                      ? NetworkImage("${widget.user?.photoURL}")
                                      : const AssetImage(
                                              'assets/images/logo.png')
                                          as ImageProvider,
                                  maxRadius: 30,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.user?.displayName}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "${widget.user?.email}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomContainerCard(
                        child: Column(
                          children: [
                            TextButton.icon(
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.white,
                                ),
                              ),
                              label: const Text(
                                "Rimuovi annunci",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: _removeAds,
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size?>(
                                      const Size(double.maxFinite, 50)),
                                  alignment: Alignment.centerLeft,
                                  overlayColor:
                                      MaterialStateProperty.all<Color?>(
                                          const Color(0x15ffffff))),
                            ),
                            TextButton.icon(
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                              ),
                              label: const Text(
                                "Condividi app",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: _shareApp,
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size?>(
                                      const Size(double.maxFinite, 50)),
                                  alignment: Alignment.centerLeft,
                                  overlayColor:
                                      MaterialStateProperty.all<Color?>(
                                          const Color(0x15ffffff))),
                            ),
                            TextButton.icon(
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
                              label: const Text(
                                "Informazioni",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: _infoApp,
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size?>(
                                      const Size(double.maxFinite, 50)),
                                  alignment: Alignment.centerLeft,
                                  overlayColor:
                                      MaterialStateProperty.all<Color?>(
                                          const Color(0x15ffffff))),
                            ),
                            TextButton.icon(
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              label: const Text(
                                "Disinstalla app",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: _shareApp,
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size?>(
                                      const Size(double.maxFinite, 50)),
                                  alignment: Alignment.centerLeft,
                                  overlayColor:
                                      MaterialStateProperty.all<Color?>(
                                          const Color(0x15ffffff))),
                            ),
                            TextButton.icon(
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                ),
                              ),
                              label: const Text(
                                "Esci",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size?>(
                                      const Size(double.maxFinite, 50)),
                                  alignment: Alignment.centerLeft,
                                  overlayColor:
                                      MaterialStateProperty.all<Color?>(
                                          const Color(0x15ffffff))),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color?>(const Color(0x15ffffff)),
                            ),
                            child: const Text("Norme sulla privacy",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          ),
                          const Icon(Icons.fiber_manual_record, size: 5),
                          TextButton(
                            onPressed: (){},
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color?>(const Color(0x15ffffff)),
                            ),
                            child: const Text("Termini di servizio",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        child: CircleAvatar(
          backgroundImage: widget.user?.photoURL != null
              ? NetworkImage("${widget.user?.photoURL}")
              : const AssetImage('assets/images/logo.png') as ImageProvider,
          maxRadius: 24,
        ),
      ),
    );
  }
}
