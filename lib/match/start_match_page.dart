import 'package:fantagita/custom%20components/button.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../custom components/container_card.dart';
import '../services/database_service.dart';

class StartMatchPage extends StatefulWidget {
  final Function(int) changePage;
  const StartMatchPage({super.key, required this.changePage});

  @override
  State<StartMatchPage> createState() => _StartMatchPageState();
}

class _StartMatchPageState extends State<StartMatchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Avvia la partita",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        CustomButton(
          onPressed: Database().startMatch,
          child: const Icon(
            Icons.play_arrow,
            size: 50,
          ),
        ),
        const SizedBox(height: 50),
        CustomContainerCard(
          color: Theme.of(context).colorScheme.onInverseSurface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Non puoi giocare da solo!\nManda il codice a qualcuno",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              CustomButton(
                  onPressed: () async {
                    Share.share(await Database().getMatchCode());
                  },
                  color: Theme.of(context).colorScheme.surface,
                  child: const Icon(Icons.share_outlined))
            ],
          ),
        ),
        const SizedBox(height: 30),
        OutlinedButton(
          onPressed: () {
              widget.changePage(1);
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Studenti partecipanti        ",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )
            ],
          ),
        ),
      ],
    );
  }
}
