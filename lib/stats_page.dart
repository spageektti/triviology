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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final List<Map<String, dynamic>> categories = [
  {'icon': Icons.question_answer, 'text': 'General Knowledge', 'id': 9},
  {'icon': Icons.book, 'text': 'Books', 'id': 10},
  {'icon': Icons.movie, 'text': 'Film', 'id': 11},
  {'icon': Icons.headphones, 'text': 'Music', 'id': 12},
  {'icon': Icons.theater_comedy, 'text': 'Musicals & Theatres', 'id': 13},
  {'icon': Icons.tv, 'text': 'Television', 'id': 14},
  {'icon': Icons.videogame_asset, 'text': 'Video Games', 'id': 15},
  {'icon': Icons.extension, 'text': 'Board Games', 'id': 16},
  {'icon': Icons.science_rounded, 'text': 'Science & Nature', 'id': 17},
  {'icon': Icons.computer, 'text': 'Computers', 'id': 18},
  {'icon': Icons.calculate, 'text': 'Mathematics', 'id': 19},
  {'icon': Icons.menu_book, 'text': 'Mythology', 'id': 20},
  {'icon': Icons.sports, 'text': 'Sports', 'id': 21},
  {'icon': Icons.map, 'text': 'Geography', 'id': 22},
  {'icon': Icons.history_edu, 'text': 'History', 'id': 23},
  {'icon': Icons.how_to_vote, 'text': 'Politics', 'id': 24},
  {'icon': Icons.brush, 'text': 'Art', 'id': 25},
  {'icon': Icons.star, 'text': 'Celebrities', 'id': 26},
  {'icon': Icons.pets, 'text': 'Animals', 'id': 27},
  {'icon': Icons.directions_car, 'text': 'Vehicles', 'id': 28},
  {'icon': Icons.my_library_books, 'text': 'Comics', 'id': 29},
  {'icon': Icons.devices_other, 'text': 'Gadgets', 'id': 30},
  {'icon': Icons.face, 'text': 'Japanese Anime & Manga', 'id': 31},
  {'icon': Icons.animation, 'text': 'Cartoon & Animations', 'id': 32},
];

class StatsPage extends StatefulWidget {
  const StatsPage(
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
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int? _selectedCategory;
  bool _statsReady = false;
  int _easyCorrect = 0;
  int _easyTotal = 0;
  int _easyQuizes = 0;
  int _mediumCorrect = 0;
  int _mediumTotal = 0;
  int _mediumQuizes = 0;
  int _hardCorrect = 0;
  int _hardTotal = 0;
  int _hardQuizes = 0;
  int _totalExperience = 0;

  Future<void> loadStats() async {
    final statsFile =
        File('${(await getApplicationDocumentsDirectory()).path}/save.json');
    final statsJson = await statsFile.readAsString();
    final stats = jsonDecode(statsJson);
    final categoryStats =
        stats[widget.databaseSavefile].containsKey(_selectedCategory.toString())
            ? stats[widget.databaseSavefile][_selectedCategory.toString()]
            : {
                'easy': {
                  'correctanswers': 0,
                  'totalquestions': 0,
                  'totalquizzes': 0,
                  'experience': 0,
                },
                'medium': {
                  'correctanswers': 0,
                  'totalquestions': 0,
                  'totalquizzes': 0,
                  'experience': 0,
                },
                'hard': {
                  'correctanswers': 0,
                  'totalquestions': 0,
                  'totalquizzes': 0,
                  'experience': 0,
                },
              };
    setState(() {
      _easyCorrect = categoryStats['easy']['correctanswers'];
      _easyTotal = categoryStats['easy']['totalquestions'];
      _easyQuizes = categoryStats['easy']['totalquizzes'];
      _mediumCorrect = categoryStats['medium']['correctanswers'];
      _mediumTotal = categoryStats['medium']['totalquestions'];
      _mediumQuizes = categoryStats['medium']['totalquizzes'];
      _hardCorrect = categoryStats['hard']['correctanswers'];
      _hardTotal = categoryStats['hard']['totalquestions'];
      _hardQuizes = categoryStats['hard']['totalquizzes'];
      _totalExperience = categoryStats['easy']['experience'] +
          categoryStats['medium']['experience'] +
          categoryStats['hard']['experience'];
      _statsReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            _selectedCategory != null
                ? categories.firstWhere(
                    (element) => element['id'] == _selectedCategory)['icon']
                : Icons.error,
            size: 50,
          ),
          DropdownButton<int>(
            value: _selectedCategory,
            hint: const Text('Select a category'),
            items: categories.map((category) {
              return DropdownMenuItem<int>(
                value: category['id'],
                child: Text(category['text']),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                _selectedCategory = newValue;
                _statsReady = false;
              });
              loadStats();
            },
          ),
          if (_selectedCategory != null && _statsReady)
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text('Easy',
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                      '$_easyCorrect/$_easyTotal questions answered correctly in $_easyQuizes quizzes'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _easyTotal != 0 ? _easyCorrect / _easyTotal : 0,
                        backgroundColor: Colors.grey,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                      '${_easyTotal != 0 ? (_easyCorrect / _easyTotal * 100).toStringAsFixed(2) : 0}%'),
                )
              ],
            ),
        ]),
      ),
    );
  }
}
