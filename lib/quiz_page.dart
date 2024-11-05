import 'package:flutter/material.dart';
import 'dart:convert';

class QuizPage extends StatefulWidget {
  const QuizPage(
      {super.key,
      required this.categoryId,
      required this.categoryName,
      required this.numOfQuestions,
      required this.difficulty,
      required this.questionType});

  final int categoryId;
  final String categoryName;
  final int numOfQuestions;
  final String difficulty;
  final String questionType;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  int _earnedExperience = 0;
  final String _currentQuestionType =
      'multiple'; // TODO: check if it is even needed
  List<dynamic> _currentQuestionAnswers = [
    'Italy',
    'Paris',
    'Warsaw',
    'I dont know I am from USA'
  ];
  String _currentQuestionCorrectAnswer = 'Paris';
  String _currentQuestionBody = 'What is the capital of France?';
  final String _jsonFromAPI = '{}';
  final Map<String, dynamic> _decodedJson = jsonDecode('''{
  "response_code": 0,
  "results": [
    {
      "type": "multiple",
      "difficulty": "medium",
      "category": "History",
      "question": "In what year did the First World War end?",
      "correct_answer": "1918",
      "incorrect_answers": [
        "1914",
        "1916",
        "1912"
      ]
    },
    {
      "type": "multiple",
      "difficulty": "easy",
      "category": "General Knowledge",
      "question": "In DC comics where does the Green Arrow (Oliver Queen) live?",
      "correct_answer": "Star City",
      "incorrect_answers": [
        "Central City",
        "Gotham City",
        "Metropolis"
      ]
    },
    {
      "type": "boolean",
      "difficulty": "easy",
      "category": "Entertainment: Music",
      "question": "American rapper Dr. Dre actually has a Ph.D. doctorate.",
      "correct_answer": "False",
      "incorrect_answers": [
        "True"
      ]
    },
    {
      "type": "multiple",
      "difficulty": "medium",
      "category": "Science: Mathematics",
      "question": "What shape does sin(x) or cos(x) make on a graph?",
      "correct_answer": "Waves",
      "incorrect_answers": [
        "A Parabola",
        "A Straight Line",
        "Zig-Zags"
      ]
    },
    {
      "type": "boolean",
      "difficulty": "easy",
      "category": "Entertainment: Video Games",
      "question": "Codemasters is the developer of the Gran Turismo series.",
      "correct_answer": "False",
      "incorrect_answers": [
        "True"
      ]
    }
  ]
}
''');

  @override
  Widget build(BuildContext context) {
    setState(() {
      _currentQuestionBody =
          _decodedJson['results'][_currentQuestion]['question'];
      _currentQuestionAnswers = _decodedJson['results'][_currentQuestion]
              ['incorrect_answers'] +
          [_decodedJson['results'][_currentQuestion]['correct_answer']];
      _currentQuestionCorrectAnswer =
          _decodedJson['results'][_currentQuestion]['correct_answer'];
    });
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
                  child: InkWell(
                    splashColor: _currentQuestionAnswers[index] ==
                            _currentQuestionCorrectAnswer
                        ? Colors.green.withAlpha(30)
                        : Colors.red.withAlpha(30),
                    onTapDown: (details) {
                      // changed from onTap to onTapDown to prevent cheating by canceling the tap
                      //print('Answer tapped: ${_currentQuestionAnswers[index]}');
                      Future.delayed(const Duration(milliseconds: 600), () {
                        setState(() {
                          _currentQuestion++;
                        });
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
                        });
                      } else {
                        //print('Wrong answer!');
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
