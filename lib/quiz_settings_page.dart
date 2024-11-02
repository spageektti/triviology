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
  final List<String> questionTypes = [
    'multiple choice',
    'true/false',
    'any type'
  ];
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
            const Text('Question type:'),
            Slider(
                value: _questionType == 'multiple'
                    ? 0
                    : _questionType == 'boolean'
                        ? 1
                        : 2,
                min: 0,
                max: 2,
                divisions: 2,
                label: questionTypes[_questionType == 'multiple'
                    ? 0
                    : _questionType == 'boolean'
                        ? 1
                        : 2],
                onChanged: (value) {
                  setState(() {
                    _questionType = value.toInt() == 0
                        ? 'multiple'
                        : value.toInt() == 1
                            ? 'boolean'
                            : '';
                  });
                }),
            ElevatedButton(
              onPressed: () {
                if (_current_setting == 3) {
                  print(
                      'Quiz started with $_numOfQuestions questions and $_difficulty difficulty.');
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
              child: _current_setting == 3
                  ? const Text('Start Quiz')
                  : const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
