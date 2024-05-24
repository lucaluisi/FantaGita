import 'package:fantagita/custom%20components/button.dart';
import 'package:flutter/material.dart';

import '../services/button_stream.dart';

class RegulationPage extends StatefulWidget {
  const RegulationPage({super.key});

  @override
  State<RegulationPage> createState() => _RegulationPageState();
}

class _RegulationPageState extends State<RegulationPage> {
  List<String> regole = [
    "Ogni giocatore ha a disposizione 100 panini per acquistare 4 studenti in gita.",
    "è obbligatorio schierare una squadra di 4 studenti.",
    "I bonus e i malus per ogni partecipante verranno attribuiti in base al seguente regolamento dall'admin della partita.",
    "L'assegnazione dei bonus e dei malus si applica ai partecipanti a partire dal primo minuto della gita fino al ritorno a casa (tutto ciò che avviene quando non si è tutti insieme non verrà conteggiato)",
    "Quando non espressamente specificato i bonus e i malus sono riferiti ad azioni compiute dal partecipante o eventi che lo coinvolgono mentre si è tutti insieme.",
    "Vince chi al termine della gita ha totalizzato il maggior numero di punti.",
    "Questo regolamento deve essere interpretato con l'intento ludico ma sempre rispettoso che anima il gioco. Nessun bonus o malus può essere interpretato come un'esortazione a compiere atti illeciti o irrispettosi nei confronti di altri individui o della collettività: fantagiuocate responsabilmente.",
  ];
  Map<String, int> bonus = {
    "Porta la cassa bluetooth": 10,
    "Arriva in orario": 10,
    "Arriva in anticipo": 20,
    "Legge un libro durante il viaggio": 10,
    "Festeggia il compleanno durante la gita (auguri!)": 15,
    "Offre la colazione a tutti": 100,
  };
  Map<String, int> malus = {
    "Arriva in ritardo": -15,
    "Fa arrabbiare il docente accompagnatore": -30,
    "Fa arrabbiare l'autista": -30,
    "Si perde": -50,
    "Viene arrestato": -300,
    "Gioca al telefono per tutto il viaggio": -10,
    "Mette canzoni napoletane durante il viaggio": -15,
  };

  @override
  Widget build(BuildContext context) {
    final buttonStream = CustomStreamController();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const ScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                    onPressed: () {
                      buttonStream.buttonPressed(1);
                    },
                    child: const Text(
                      "Regole",
                      style: TextStyle(color: Colors.white),
                    )),
                CustomButton(
                    onPressed: () {
                      buttonStream.buttonPressed(2);
                    },
                    child: const Text(
                      "Bonus e malus",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            const SizedBox(height: 30),
            StreamBuilder<int>(
              stream: buttonStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == 2) {
                  return Column(
                    children: [
                      const Text(
                        "Bonus",
                        style: TextStyle(color: Colors.green, fontSize: 24),
                      ),
                      ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: bonus.entries.map(
                                (entry) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.radio_button_on),
                                    title: Text(
                                      entry.key,
                                    ),
                                    trailing: Text(
                                      "+${entry.value.toString()}",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.green),
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    thickness: 2,
                                  )
                                ],
                              );
                            },
                          ).toList()),
                      const SizedBox(height: 20),
                      const Text(
                        "Malus",
                        style: TextStyle(color: Colors.red, fontSize: 24),
                      ),
                      ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: malus.entries.map(
                                (entry) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.radio_button_on),
                                    title: Text(
                                      entry.key,
                                    ),
                                    trailing: Text(
                                      entry.value.toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.red),
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    thickness: 2,
                                  )
                                ],
                              );
                            },
                          ).toList()),
                    ],
                  );
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: regole.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.radio_button_on),
                            title: Text(
                              regole[index],
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.onBackground,
                            thickness: 2,
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
