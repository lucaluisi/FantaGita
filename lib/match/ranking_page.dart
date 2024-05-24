import 'package:fantagita/custom%20components/button.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final database = Database();

  List<Widget> _buildWidgetList(Map<String, Map<String, dynamic>> data) {
    List<Widget> texts = [];
    int pos = 1;
    data.forEach((key, value) {
      if (value['squad'].length == 4) {
        texts.add(CustomButton(
          onPressed: () {},
          color: Theme
              .of(context)
              .colorScheme
              .onInverseSurface,
          child: Table(
            columnWidths: const {1: FlexColumnWidth(3)},
            //border: TableBorder.all(color: Colors.white),
            children: [
              TableRow(
                children: [
                  Text("$pos°",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .onSurface)),
                  Text(
                    value['username'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text("${database.getPoints(data, key)} pt",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .onSurface)),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ],
          ),
        ));
        texts.add(const SizedBox(height: 10));
        pos += 1;
      }
    });
    return texts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Classifica",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            StreamBuilder<Object>(
              stream: database.getMatchSnapshots(),
              builder: (BuildContext context, AsyncSnapshot databaseSnapshot) {
                return FutureBuilder(
                  future: database.getUsersInMatchList(),
                  builder: (context, AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Column(children: _buildWidgetList(snapshot.data!));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
