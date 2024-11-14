/*
* Triviology - a fun and challenging trivia app to test your knowledge on various topics.
* Copyright (C) 2024  Wiktor Perskawiec <contact@spageektti.cc>

? This program is free software: you can redistribute it and/or modify
? it under the terms of the GNU General Public License as published by
? the Free Software Foundation, either version 3 of the License, or
? (at your option) any later version.

! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.

* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
/* 
! To contribute, please read the CONTRIBUTING.md file in the root of the project.
? It contains important information about the project structure, code style, suggested VSCode extensions, and more.
*/
import 'package:flutter/material.dart';
import 'package:triviology/home_page.dart';
import 'package:triviology/stats_page.dart';
import 'package:triviology/settings_page.dart';

class NavigationWidget extends StatefulWidget {
  final int selectedIndex;
  final String databaseName;
  final String databaseUrl;
  final String databaseCodename;
  final String databaseSavefile;

  const NavigationWidget({
    super.key,
    this.selectedIndex = 0,
    required this.databaseName,
    required this.databaseUrl,
    required this.databaseCodename,
    required this.databaseSavefile,
  });

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  late PageController _pageController;
  late List<Widget> _pages;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _pageController = PageController(initialPage: _selectedIndex);
    _pages = <Widget>[
      HomePage(
        databaseName: widget.databaseName,
        databaseUrl: widget.databaseUrl,
        databaseCodename: widget.databaseCodename,
        databaseSavefile: widget.databaseSavefile,
      ),
      StatsPage(
        databaseName: widget.databaseName,
        databaseUrl: widget.databaseUrl,
        databaseCodename: widget.databaseCodename,
        databaseSavefile: widget.databaseSavefile,
      ),
      const SettingsPage(),
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
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined_outlined),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
