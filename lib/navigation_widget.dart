import 'package:flutter/material.dart';
import 'package:triviology/home_page.dart';
import 'package:triviology/stats_page.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget(
      {super.key,
      required this.databaseName,
      required this.databaseUrl,
      required this.databaseCodename,
      required this.databaseSavefile});

  final String databaseName;
  final String databaseUrl;
  final String databaseCodename;
  final String databaseSavefile;

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePage(
        databaseName: widget.databaseName,
        databaseUrl: widget.databaseUrl,
        databaseCodename: widget.databaseCodename,
        databaseSavefile: widget.databaseSavefile,
      ),
      const StatsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
