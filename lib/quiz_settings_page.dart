import 'package:flutter/material.dart';
import 'package:triviology/quiz_page.dart';

class QuizSettingsPage extends StatefulWidget {
  const QuizSettingsPage({super.key, required this.categoryId});

  final int categoryId;

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
              const Text('Difficulty:'),
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
              ),
            ],
            if (_current_setting == 2) ...[
              const Text('Question type:'),
              Slider(
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
