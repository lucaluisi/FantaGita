import 'package:fantagita/custom%20components/button.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../custom components/container_card.dart';
import '../services/database_service.dart';

class StartSquadChoosePage extends StatefulWidget {
  final Function(int) changePage;
  const StartSquadChoosePage({super.key, required this.changePage});

  @override
  State<StartSquadChoosePage> createState() => _StartSquadChoosePageState();
}

class _StartSquadChoosePageState extends State<StartSquadChoosePage> {
  final database = Database();

  List<Widget> _buildWidgetList(Map<String, Map<String, dynamic>> data) {
    List<Widget> texts = [];
    data.forEach((key, value) {
      final controller = TextEditingController();
      texts.add(CustomContainerCard(
        color: Theme.of(context).colorScheme.onInverseSurface,
        child: Table(
          children: [
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    value['username'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        hintText: "${value['price']}",
                      ),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                      controller: controller,
                      //onChanged: (newPrice) {database.setPrice(key, newPrice.isNotEmpty ? int.parse(newPrice) : 0);},
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: OutlinedButton(
                    onPressed: (){
                      database.setPrice(key, controller.text.isNotEmpty ? int.parse(controller.text) : 0);
                    },
                    child: const Text("SET", style: TextStyle(color: Colors.white)),
                  )
                ),
              ],
            ),
          ],
        ),
      ));
      texts.add(const SizedBox(height: 10));
    });
    return texts;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Avvia la scelta delle squadre",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
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
        const Icon(Icons.arrow_downward),
        const SizedBox(height: 30),
        StreamBuilder<Object>(
          stream: database.getMatchSnapshots(),
          builder: (BuildContext context, AsyncSnapshot databaseSnapshot) {
            return FutureBuilder(
              future: database.getUsersInMatchList(),
              builder: (context,
                  AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Column(children: _buildWidgetList(snapshot.data!));
                }
              },
            );
          },
        ),
      ],
    );
  }
}
