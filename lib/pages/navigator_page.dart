import 'package:fantagita/custom%20components/account_card.dart';
import 'package:fantagita/match/match_page.dart';
import 'package:fantagita/match/ranking_page.dart';
import 'package:fantagita/pages/regulation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigatorPage extends StatefulWidget {
  final User? user;
  const NavigatorPage({super.key, required this.user});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  void _changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/images/title.png"),
          width: 220.0,
        ),
        centerTitle: true,
        toolbarHeight: 70,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: AccountCard(user: widget.user)),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: <Widget>[
          MatchPage(user: widget.user, changePage: _changePage),
          const RankingPage(),
          const RegulationPage(),
          Card(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          _changePage(index);
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups),
            label: 'Classifica',
          ),
          NavigationDestination(
            icon: Icon(Icons.article),
            label: 'Regolamento',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Impostazioni',
          ),
        ],
      ),
    );
  }
}
