import 'package:fantagita/custom%20components/account_card.dart';
import 'package:fantagita/custom%20components/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';

class MatchPage extends StatefulWidget {
  final User? user;
  const MatchPage({super.key, required this.user});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  Widget _buildWidgetList(Map<String, int> data) {
    int endKey = 0;
    Map<String, int> subMap = {};
    data.forEach((key, value) {
      if (endKey < 5) {
        subMap[key] = value;
        endKey++;
      }
    });

    List<TableRow> texts = [];
    int pos = 1;
    subMap.forEach((key, value) {
      texts.add(TableRow(
        children: [
          Text("${pos}°",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface)),
          Text(
            key,
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text("$value pt",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface)),
        ],
      ));
      pos += 1;
    });
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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Table(
        children: texts,
        columnWidths: {0: FixedColumnWidth(50), 2: FixedColumnWidth(50)},
        textBaseline: TextBaseline.ideographic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/images/title.png"),
          width: 230.0,
        ),
        centerTitle: true,
        toolbarHeight: 70,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: AccountCard(user: widget.user)),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: Database().getUsersInMatchList(widget.user),
                  builder: (context, AsyncSnapshot<Map<String, int>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return _buildWidgetList(snapshot.data!);
                    }
                  },
                ),
                SizedBox(height: 100),
                OutlinedButton(onPressed: () {setState(() {});}, child: const Text("refresh"))
              ],
            ),
          ),
        )),
      ),
    );
  }
}