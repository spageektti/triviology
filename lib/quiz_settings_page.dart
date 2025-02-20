/*
* quiz_settings_page.dart - page where you choose difficulty and question type.
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
import 'package:triviology/quiz_page.dart';

class QuizSettingsPage extends StatefulWidget {
  const QuizSettingsPage(
      {super.key,
      required this.categoryId,
      required this.categoryName,
      required this.databaseName,
      required this.databaseUrl,
      required this.databaseCodename,
      required this.databaseSavefile,
      required this.databaseType,
      required this.apiUrl,
      required this.questions,
      required this.questionCount});

  final int categoryId;
  final String categoryName;
  final String databaseName;
  final String databaseUrl;
  final String databaseCodename;
  final String databaseSavefile;
  final String databaseType;
  final String apiUrl;
  final String questions;
  final String questionCount;

  @override
  _QuizSettingsPageState createState() => _QuizSettingsPageState();
}

class _QuizSettingsPageState extends State<QuizSettingsPage> {
  int _numOfQuestions = 1;
  String _difficulty = 'easy';
  String _questionType = 'multiple';
  int _current_setting = 0;
  int _countOfQuestionsForCurrentSetting = 25;

  late Map<dynamic, dynamic> _decodedQuestionCount;

  @override
  void initState() {
    super.initState();
    if (widget.apiUrl == "None") {
      _decodedQuestionCount = jsonDecode(widget.questionCount);
    } else {
      _decodedQuestionCount = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_decodedQuestionCount);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_current_setting == 0) ...[
              /*const Text('Difficulty:'),
              Slider(
                value: _difficulty == 'easy'
                    ? 0
                    : _difficulty == 'medium'
                        ? 1
                        : 2,
                min: 0,
                max: 2,
                divisions: 2,
                label: _difficulty,
                onChanged: (value) {
                  setState(() {
                    switch (value.toInt()) {
                      case 0:
                        _difficulty = 'easy';
                        break;
                      case 1:
                        _difficulty = 'medium';
                        break;
                      case 2:
                        _difficulty = 'hard';
                        break;
                    }
                  });
                },
              ),*/
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 150,
                    width: 140,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Easy', style: TextStyle(fontSize: 20)),
                            const Icon(Icons.star_rounded,
                                color: Colors.yellow),
                            const Text('    1XP  / answer    '),
                            Radio(
                              value: 'easy',
                              groupValue: _difficulty,
                              onChanged: (value) {
                                setState(() {
                                  _difficulty = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: 140,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Medium',
                                style: TextStyle(fontSize: 20)),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star_rounded, color: Colors.yellow),
                                Icon(Icons.star_rounded, color: Colors.yellow),
                              ],
                            ),
                            const Text('    2XP  / answer    '),
                            Radio(
                              value: 'medium',
                              groupValue: _difficulty,
                              onChanged: (value) {
                                setState(() {
                                  _difficulty = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: 140,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Hard', style: TextStyle(fontSize: 20)),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star_rounded, color: Colors.yellow),
                                Icon(Icons.star_rounded, color: Colors.yellow),
                                Icon(Icons.star_rounded, color: Colors.yellow),
                              ],
                            ),
                            const Text('    3XP  / answer    '),
                            Radio(
                              value: 'hard',
                              groupValue: _difficulty,
                              onChanged: (value) {
                                setState(() {
                                  _difficulty = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (_current_setting == 1) ...[
              const Text('Question type:'),
              /*Slider(
                value: _questionType == 'boolean'
                    ? 0
                    : _questionType == 'multiple'
                        ? 1
                        : 2,
                min: 0,
                max: 2,
                divisions: 2,
                label: _questionType == 'multiple'
                    ? 'Multiple Choice'
                    : _questionType == 'boolean'
                        ? 'True/False'
                        : 'Any Type',
                onChanged: (value) {
                  setState(() {
                    _questionType = value.toInt() == 0
                        ? 'boolean'
                        : value.toInt() == 1
                            ? 'multiple'
                            : '';
                  });
                },
              ),*/
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: SizedBox(
                      width: 140,
                      child: Card(
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.check_box_outlined,
                                    color: Colors.green, size: 40),
                                Icon(Icons.check_box_outline_blank_outlined,
                                    color: Colors.red, size: 40),
                                Icon(Icons.check_box_outline_blank_outlined,
                                    color: Colors.red, size: 40),
                              ],
                            ),
                            const Text('Multiple Choice',
                                style: TextStyle(fontSize: 18)),
                            Radio(
                              value: 'multiple',
                              groupValue: _questionType,
                              onChanged: (value) {
                                setState(() {
                                  _questionType = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: SizedBox(
                      width: 140,
                      child: Card(
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 40,
                                ),
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ],
                            ),
                            const Text('True/False',
                                style: TextStyle(fontSize: 18)),
                            Radio(
                              value: 'boolean',
                              groupValue: _questionType,
                              onChanged: (value) {
                                setState(() {
                                  _questionType = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: SizedBox(
                      width: 140,
                      child: Card(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.shuffle, // Icons.casino_outlined
                              size: 40,
                            ),
                            const Text('Any type',
                                style: TextStyle(fontSize: 18)),
                            Radio(
                              value: 'any',
                              groupValue: _questionType,
                              onChanged: (value) {
                                setState(() {
                                  _questionType = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (_current_setting == 2) ...[
              const Text('Number of questions:'),
              Slider(
                value: _numOfQuestions.toDouble(),
                min: 1,
                max: widget.apiUrl == "None"
                    ? _countOfQuestionsForCurrentSetting * 1.0
                    : 25,
                divisions: widget.apiUrl == "None"
                    ? (_countOfQuestionsForCurrentSetting > 1
                        ? _countOfQuestionsForCurrentSetting - 1
                        : 1)
                    : 24,
                label: _numOfQuestions.toString(),
                onChanged: (double value) {
                  setState(() {
                    _numOfQuestions = value.toInt();
                  });
                },
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_current_setting > 0) ...[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _current_setting--;
                      });
                    },
                    child: const Text('Previous'),
                  ),
                ],
                ElevatedButton(
                  onPressed: () {
                    if (widget.apiUrl == "None") {
                      print(_decodedQuestionCount[widget.categoryId.toString()]
                          [_difficulty][_questionType]);
                      _countOfQuestionsForCurrentSetting =
                          _decodedQuestionCount[widget.categoryId.toString()]
                              [_difficulty][_questionType];
                    }
                    print(widget.databaseType);
                    if (_current_setting == 2) {
                      print(
                          'Quiz started with $_numOfQuestions questions, $_difficulty difficulty, and $_questionType question type.');
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return QuizPage(
                          categoryId: widget.categoryId,
                          categoryName: widget.categoryName,
                          numOfQuestions: _numOfQuestions,
                          difficulty: _difficulty,
                          questionType: _questionType,
                          databaseName: widget.databaseName,
                          databaseUrl: widget.databaseUrl,
                          databaseCodename: widget.databaseCodename,
                          databaseSavefile: widget.databaseSavefile,
                          databaseType: widget.databaseType,
                          apiUrl: widget.apiUrl,
                          questions: widget.questions,
                        );
                      }), (route) => false);
                    } else {
                      setState(() {
                        _current_setting++;
                      });
                    }
                  },
                  child: _current_setting == 2
                      ? const Text('Start Quiz')
                      : const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
