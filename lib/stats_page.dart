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
import 'achievements_page.dart';
import 'dart:math';

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
  int _totalCorrect = 0;
  int _totalQuestions = 0;
  int _totalQuizes = 0;
  int _easyMaxCorrectAnswersStreak = 0;
  int _easyMaxIncorrectAnswersStreak = 0;
  int _mediumMaxCorrectAnswersStreak = 0;
  int _mediumMaxIncorrectAnswersStreak = 0;
  int _hardMaxCorrectAnswersStreak = 0;
  int _hardMaxIncorrectAnswersStreak = 0;

  Future<void> loadStats() async {
    final statsFile =
        File('${(await getApplicationDocumentsDirectory()).path}/save.json');
    if (await statsFile.exists() == false) {
      await statsFile.writeAsString(jsonEncode({
        widget.databaseSavefile: {
          _selectedCategory.toString(): {
            'easy': {
              'correctanswers': 0,
              'totalquestions': 0,
              'totalquizzes': 0,
              'experience': 0,
              'maxCorrectAnswersStreak': 0,
              'maxIncorrectAnswersStreak': 0
            },
            'medium': {
              'correctanswers': 0,
              'totalquestions': 0,
              'totalquizzes': 0,
              'experience': 0,
              'maxCorrectAnswersStreak': 0,
              'maxIncorrectAnswersStreak': 0
            },
            'hard': {
              'correctanswers': 0,
              'totalquestions': 0,
              'totalquizzes': 0,
              'experience': 0,
              'maxCorrectAnswersStreak': 0,
              'maxIncorrectAnswersStreak': 0
            }
          }
        }
      }));
    }
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
                  'maxCorrectAnswersStreak': 0,
                  'maxIncorrectAnswersStreak': 0
                },
                'medium': {
                  'correctanswers': 0,
                  'totalquestions': 0,
                  'totalquizzes': 0,
                  'experience': 0,
                  'maxCorrectAnswersStreak': 0,
                  'maxIncorrectAnswersStreak': 0
                },
                'hard': {
                  'correctanswers': 0,
                  'totalquestions': 0,
                  'totalquizzes': 0,
                  'experience': 0,
                  'maxCorrectAnswersStreak': 0,
                  'maxIncorrectAnswersStreak': 0
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
      _totalCorrect = _easyCorrect + _mediumCorrect + _hardCorrect;
      _totalQuestions = _easyTotal + _mediumTotal + _hardTotal;
      _totalQuizes = _easyQuizes + _mediumQuizes + _hardQuizes;
      _easyMaxCorrectAnswersStreak =
          categoryStats['easy']['maxCorrectAnswersStreak'];
      _easyMaxIncorrectAnswersStreak =
          categoryStats['easy']['maxIncorrectAnswersStreak'];
      _mediumMaxCorrectAnswersStreak =
          categoryStats['medium']['maxCorrectAnswersStreak'];
      _mediumMaxIncorrectAnswersStreak =
          categoryStats['medium']['maxIncorrectAnswersStreak'];
      _hardMaxCorrectAnswersStreak =
          categoryStats['hard']['maxCorrectAnswersStreak'];
      _hardMaxIncorrectAnswersStreak =
          categoryStats['hard']['maxIncorrectAnswersStreak'];
    });
  }

  double logBase(num x, num base) => log(x) / log(base);
  double log2(num x) => logBase(x, 2);

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
                Text(
                    'Level ${_totalExperience == 0 ? 0 : log2(_totalExperience).floor()}',
                    style: const TextStyle(fontSize: 18)),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _totalExperience == 0
                                ? 0
                                : (_totalExperience /
                                    (pow(2, log2(_totalExperience).floor()) *
                                        2)),
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.green),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                          '${_totalExperience == 0 ? 0 : (_totalExperience / (pow(2, log2(_totalExperience).floor()) * 2) * 100).toStringAsFixed(2)}% of next level ($_totalExperience/${_totalExperience == 0 ? 0 : (pow(2, log2(_totalExperience).floor()) * 2)} XP)'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Easy',
                            style:
                                TextStyle(color: Colors.green, fontSize: 20)),
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
                              value: _easyTotal != 0
                                  ? _easyCorrect / _easyTotal
                                  : 0,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                            '${_easyTotal != 0 ? (_easyCorrect / _easyTotal * 100).toStringAsFixed(2) : 0}%'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Medium',
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                            '$_mediumCorrect/$_mediumTotal questions answered correctly in $_mediumQuizes quizzes'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: _mediumTotal != 0
                                  ? _mediumCorrect / _mediumTotal
                                  : 0,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                            '${_mediumTotal != 0 ? (_mediumCorrect / _mediumTotal * 100).toStringAsFixed(2) : 0}%'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Hard',
                            style: TextStyle(color: Colors.red, fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                            '$_hardCorrect/$_hardTotal questions answered correctly in $_hardQuizes quizzes'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: _hardTotal != 0
                                  ? _hardCorrect / _hardTotal
                                  : 0,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                            '${_hardTotal != 0 ? (_hardCorrect / _hardTotal * 100).toStringAsFixed(2) : 0}%'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Total', style: TextStyle(fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                            '$_totalCorrect/$_totalQuestions questions answered correctly in $_totalQuizes quizzes'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: _totalQuestions != 0
                                  ? _totalCorrect / _totalQuestions
                                  : 0,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                            '${_totalQuestions != 0 ? (_totalCorrect / _totalQuestions * 100).toStringAsFixed(2) : 0}%'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_statsReady) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AchievementsPage(
                    easyCorrect: _easyCorrect,
                    easyTotal: _easyTotal,
                    easyQuizes: _easyQuizes,
                    mediumCorrect: _mediumCorrect,
                    mediumTotal: _mediumTotal,
                    mediumQuizes: _mediumQuizes,
                    hardCorrect: _hardCorrect,
                    hardTotal: _hardTotal,
                    hardQuizes: _hardQuizes,
                    totalExperience: _totalExperience,
                    totalCorrect: _totalCorrect,
                    totalQuestions: _totalQuestions,
                    totalQuizes: _totalQuizes,
                    categoryName: categories.firstWhere((element) =>
                        element['id'] == _selectedCategory)['text'],
                    categoryIcon: Icon(categories.firstWhere((element) =>
                        element['id'] == _selectedCategory)['icon']),
                    easyMaxCorrectAnswersStreak: _easyMaxCorrectAnswersStreak,
                    easyMaxIncorrectAnswersStreak:
                        _easyMaxIncorrectAnswersStreak,
                    mediumMaxCorrectAnswersStreak:
                        _mediumMaxCorrectAnswersStreak,
                    mediumMaxIncorrectAnswersStreak:
                        _mediumMaxIncorrectAnswersStreak,
                    hardMaxCorrectAnswersStreak: _hardMaxCorrectAnswersStreak,
                    hardMaxIncorrectAnswersStreak:
                        _hardMaxIncorrectAnswersStreak,
                  ),
                ),
              );
            }
          },
          child: const Icon(
            Icons.emoji_events_outlined,
            size: 35,
          )),
    );
  }
}
