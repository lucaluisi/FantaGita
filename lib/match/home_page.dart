import 'package:fantagita/custom%20components/button.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final database = Database();

  Widget _buildWidgetList(Map<String, Map<String, dynamic>> data) {
    int endKey = 0;
    List<String> subMap = [];
    data.forEach((key, value) {
      if (endKey < 5) {
        subMap.add(key);
        endKey++;
      }
    });

    List<TableRow> texts = [];
    int pos = 1;
    for (var key in subMap) {
      texts.add(TableRow(
        children: [
          Text("$pos°",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface)),
          Text(
            data[key]?['username'],
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text("${database.getPoints(data, key)} pt",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface)),
        ],
      ));
      pos += 1;
    }
    texts.add(TableRow(children: [
      const SizedBox(),
      Text("...",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, color: Theme.of(context).colorScheme.onSurface)),
      const SizedBox(),
    ]));
    return CustomButton(
      onPressed: () {},
      color: Theme.of(context).colorScheme.onInverseSurface,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Table(
        children: texts,
        columnWidths: const {1: FlexColumnWidth(3)},
        textBaseline: TextBaseline.ideographic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: database.getUsersInMatchList(),
            builder: (context,
                AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}'));
              } else {
                return _buildWidgetList(snapshot.data!);
              }
            },
          ),
          const SizedBox(height: 100),
          OutlinedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("refresh"))
        ],
      );
  }
}
