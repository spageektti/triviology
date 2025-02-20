/*
* quiz_page.dart - The main quiz page where the user can answer questions.
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
import 'dart:math';
import 'package:triviology/navigation_widget.dart';
import 'package:triviology/quiz_summary_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.numOfQuestions,
    required this.difficulty,
    required this.questionType,
    required this.databaseName,
    required this.databaseUrl,
    required this.databaseCodename,
    required this.databaseSavefile,
    required this.databaseType,
    required this.apiUrl,
    required this.questions,
  });

  final int categoryId;
  final String categoryName;
  final int numOfQuestions;
  final String difficulty;
  final String questionType;
  final String databaseName;
  final String databaseUrl;
  final String databaseCodename;
  final String databaseSavefile;
  final String databaseType;
  final String apiUrl;
  final String questions;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  int _earnedExperience = 0;
  int _correctlyAnsweredQuestions = 0;
  List<dynamic> _currentQuestionAnswers = ['...', '...', '...', '...'];
  String _currentQuestionCorrectAnswer = '...';
  bool _clickable = false;
  String _currentQuestionBody = 'loading...';
  List<List<dynamic>> _answersForAll = [];
  bool _showCardColor = false;
  int _correctAnswersStreak = 0;
  int _incorrectAnswersStreak =
      0; // I know it may look weird but this achievement is as hard to get as the correct answers streak because you need to always answer wrong
  int _maxCorrectAnswersStreak = 0;
  int _maxIncorrectAnswersStreak = 0;

  Map<String, dynamic>? _decodedJson;
  Future<void> _fetchQuestionsFromApi() async {
    String url =
        "${widget.apiUrl}?amount=${widget.numOfQuestions}&category=${widget.categoryId}&difficulty=${widget.difficulty}";
    if (widget.questionType != 'any') {
      url += '&type=${widget.questionType}';
    }

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);

        if (decodedJson['response_code'] == 0) {
          setState(() {
            _decodedJson = decodedJson;
            _answersForAll =
                decodedJson['results'].map<List<dynamic>>((question) {
              List<dynamic> answers =
                  question['incorrect_answers'] + [question['correct_answer']];
              answers.shuffle();
              return answers
                  .map((answer) =>
                      htmlParser.parse(answer).documentElement?.text)
                  .toList();
            }).toList();
            _currentQuestionBody = htmlParser
                    .parse(decodedJson['results'][_currentQuestion]['question'])
                    .documentElement
                    ?.text ??
                'loading...'; // Decode question
            _clickable = true;
          });
        } else if (decodedJson['response_code'] == 1) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      'There are not enough questions in the category/difficulty combination you selected. Please try again with different settings, or change the questions source.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false);
                      },
                      child: const Text('OK'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => NavigationWidget(
                                    databaseCodename: widget.databaseCodename,
                                    databaseName: widget.databaseName,
                                    databaseSavefile: widget.databaseSavefile,
                                    databaseUrl: widget.databaseUrl,
                                    selectedIndex: 2)),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text('Settings'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          print('Error: Response code ${decodedJson['response_code']}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> _fetchQuestionsFromLocal() async {
    final Map<String, dynamic> decodedJson =
        jsonDecode(widget.questions); // map of ALL questions in the database
    print(decodedJson);
    final List<dynamic> questions = widget.questionType == 'boolean'
        ? decodedJson['boolean'][widget.categoryId.toString()]
            [widget.difficulty]
        : widget.questionType == 'multiple'
            ? decodedJson['multiple'][widget.categoryId.toString()]
                [widget.difficulty]
            : decodedJson['boolean'][widget.categoryId.toString()]
                    [widget.difficulty] +
                decodedJson['multiple'][widget.categoryId.toString()]
                    [widget.difficulty]; // list of questions
    print(questions);
    final List<dynamic> shuffledQuestions = List.from(questions)
      ..shuffle(); // shuffle the questions
    if (shuffledQuestions.length < widget.numOfQuestions) {
      if (mounted) {
        // I know it is not the best solution, but It works for now
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'There are not enough questions in the category/difficulty combination you selected. Please try again with different settings, or change the questions source.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => NavigationWidget(
                                  databaseCodename: widget.databaseCodename,
                                  databaseName: widget.databaseName,
                                  databaseSavefile: widget.databaseSavefile,
                                  databaseUrl: widget.databaseUrl,
                                  selectedIndex: 2)),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text('Settings'),
                  ),
                ],
              );
            },
          );
        }
      }
    } else {
      setState(() {
        _decodedJson = {
          'results': shuffledQuestions.sublist(0, widget.numOfQuestions)
        };
        _answersForAll =
            _decodedJson?['results'].map<List<dynamic>>((question) {
          List<dynamic> answers =
              question['incorrect_answers'] + [question['correct_answer']];
          answers.shuffle();
          return answers
              .map((answer) => htmlParser.parse(answer).documentElement?.text)
              .toList();
        }).toList();
        _currentQuestionBody = htmlParser
                .parse(_decodedJson?['results'][_currentQuestion]['question'])
                .documentElement
                ?.text ??
            'loading...'; // Decode question
        _clickable = true;
      });
    }
    // select only the number of questions that is needed
  }

  Future<void> _fetchQuestions() async {
    if (widget.databaseType == 'api') {
      await _fetchQuestionsFromApi();
    } else {
      await _fetchQuestionsFromLocal();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_decodedJson == null) {
      _fetchQuestions().then((_) {
        setState(() {}); // Ensure the widget rebuilds after fetching questions
        // I do not know why I have to do this (It just should refresh because the setState is called somewhere else), but it works
        // Rule number 1 of programming: If it works, don't touch it
      });
    } else if (_currentQuestion < _decodedJson?['results'].length) {
      setState(() {
        _currentQuestionBody = htmlParser
                .parse(_decodedJson?['results'][_currentQuestion]['question'])
                .documentElement
                ?.text ??
            'loading...';
        _currentQuestionAnswers = _answersForAll[_currentQuestion];
        _currentQuestionCorrectAnswer = htmlParser
                .parse(_decodedJson?['results'][_currentQuestion]
                    ['correct_answer'])
                .documentElement
                ?.text ??
            '...';
        print(_currentQuestionCorrectAnswer);
        print(_currentQuestionAnswers);
      });
    }
    // I have NO IDEA how to add loading screen here, but I need to do something about the delay in fetching the questions
    // TODO: add loading screen
    // I am actually gonna create a github issue for this so I dont forget about it
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('$_earnedExperience XP'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Text(
              widget.difficulty[0].toUpperCase(),
              style: TextStyle(
                  color: widget.difficulty == 'easy'
                      ? Colors.greenAccent
                      : widget.difficulty == 'medium'
                          ? Colors.orangeAccent
                          : Colors.redAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              widget.questionType[0].toUpperCase(),
              style: TextStyle(
                  color: widget.questionType == 'multiple'
                      ? Colors.blueAccent
                      : widget.questionType == 'boolean'
                          ? Colors.purpleAccent
                          : Colors.yellowAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('$_currentQuestion/${widget.numOfQuestions}'),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Exit'),
                  content: const Text(
                      'Are you sure you want to exit the quiz? You current progress will not be saved.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/',
                            (Route<dynamic> route) =>
                                false); // Navigate back to home
                      },
                      child: const Text('Exit'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_currentQuestionBody, style: const TextStyle(fontSize: 20)),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _currentQuestionAnswers.length,
              itemBuilder: (context, index) {
                /*return InkWell(
                  onTap: () {
                    // do something xd
                  },
                  child: Card(
                    color: Colors.blueAccent,
                    child: Center(
                      child: Text(
                        _currentQuestionAnswers[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );*/
                return Card(
                  color: _showCardColor
                      ? _currentQuestionAnswers[index] ==
                              _currentQuestionCorrectAnswer
                          ? Colors.green.withAlpha(40)
                          : Colors.red.withAlpha(40)
                      : Theme.of(context)
                          .cardTheme
                          .color, // Theme.of(context).cardColor is different from Theme.of(context).cardTheme.color, it is equal to the background color of the scaffold, so we need to use cardTheme.color
                  child: InkWell(
                    splashColor: _currentQuestionAnswers[index] ==
                            _currentQuestionCorrectAnswer
                        ? Colors.green.withAlpha(30)
                        : Colors.red.withAlpha(30),
                    onTapDown: (details) {
                      if (_clickable) {
                        // changed from onTap to onTapDown toprevent cheating by canceling the tap
                        //print('Answer tapped: ${_currentQuestionAnswers[index]}');
                        Future.delayed(const Duration(milliseconds: 400), () {
                          setState(() {
                            _showCardColor = true;
                          });
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            setState(() {
                              {
                                _clickable = true;
                                _showCardColor = false;
                                _currentQuestion++;
                              }
                            });
                          });
                        });
                        setState(() {
                          _clickable = false;
                        });
                        if (_currentQuestionAnswers[index] ==
                            _currentQuestionCorrectAnswer) {
                          //print('Correct answer!');
                          setState(() {
                            _earnedExperience += widget.difficulty == 'easy'
                                ? 1
                                : widget.difficulty == 'medium'
                                    ? 2
                                    : 3;

                            _correctAnswersStreak++;

                            _maxCorrectAnswersStreak = max(
                                _maxCorrectAnswersStreak,
                                _correctAnswersStreak);
                            _maxIncorrectAnswersStreak = max(
                                _maxIncorrectAnswersStreak,
                                _incorrectAnswersStreak);

                            _incorrectAnswersStreak = 0;

                            _correctlyAnsweredQuestions++;
                          });
                        } else {
                          _incorrectAnswersStreak++;

                          _maxCorrectAnswersStreak = max(
                              _maxCorrectAnswersStreak, _correctAnswersStreak);
                          _maxIncorrectAnswersStreak = max(
                              _maxIncorrectAnswersStreak,
                              _incorrectAnswersStreak);

                          _correctAnswersStreak = 0;
                        }
                        if (_currentQuestion == widget.numOfQuestions - 1) {
                          if (mounted) {
                            Future.delayed(const Duration(milliseconds: 1500),
                                () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => QuizSummaryPage(
                                        categoryName: widget.categoryName,
                                        categoryId: widget.categoryId,
                                        numOfQuestions: widget.numOfQuestions,
                                        difficulty: widget.difficulty,
                                        questionType: widget.questionType,
                                        earnedExperience: _earnedExperience,
                                        correctlyAnsweredQuestions:
                                            _correctlyAnsweredQuestions,
                                        databaseName: widget.databaseName,
                                        databaseUrl: widget.databaseUrl,
                                        databaseCodename:
                                            widget.databaseCodename,
                                        databaseSavefile:
                                            widget.databaseSavefile,
                                        maxCorrectAnswersStreak:
                                            _maxCorrectAnswersStreak,
                                        maxIncorrectAnswersStreak:
                                            _maxIncorrectAnswersStreak,
                                      )));
                            });
                          }
                        }
                      }
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(_currentQuestionAnswers[index] as String),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
