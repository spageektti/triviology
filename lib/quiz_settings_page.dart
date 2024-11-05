import 'package:flutter/material.dart';
import 'package:triviology/quiz_page.dart';

class QuizSettingsPage extends StatefulWidget {
  const QuizSettingsPage(
      {super.key, required this.categoryId, required this.categoryName});

  final int categoryId;
  final String categoryName;

  @override
  _QuizSettingsPageState createState() => _QuizSettingsPageState();
}

class _QuizSettingsPageState extends State<QuizSettingsPage> {
  int _numOfQuestions = 5;
  String _difficulty = 'easy';
  String _questionType = 'multiple';
  int _current_setting = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_current_setting == 0) ...[
              const Text('Number of questions:'),
              Slider(
                value: _numOfQuestions.toDouble(),
                min: 1,
                max: 50,
                divisions: 49,
                label: _numOfQuestions.toString(),
                onChanged: (double value) {
                  setState(() {
                    _numOfQuestions = value.toInt();
                  });
                },
              ),
            ],
            if (_current_setting == 1) ...[
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 150,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Medium',
                                style: TextStyle(fontSize: 20)),
                            const Row(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Hard', style: TextStyle(fontSize: 20)),
                            const Row(
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
            if (_current_setting == 2) ...[
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
            ElevatedButton(
              onPressed: () {
                if (_current_setting == 2) {
                  print(
                      'Quiz started with $_numOfQuestions questions, $_difficulty difficulty, and $_questionType question type.');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return QuizPage(
                      categoryId: widget.categoryId,
                      categoryName: widget.categoryName,
                      numOfQuestions: _numOfQuestions,
                      difficulty: _difficulty,
                      questionType: _questionType,
                    );
                  }));
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
      ),
    );
  }
}
