import 'package:flutter/material.dart';

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
  final String _currentQuestionType = 'multiple';
  final List<String> _currentQuestionAnswers = [
    'Italy',
    'Paris',
    'Warsaw',
    'I dont know I am from USA'
  ];
  final String _currentQuestionCorrectAnswer = 'Paris';
  final String _currentQuestionBody = 'What is the capital of France?';

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {
                      print('Answer tapped: ${_currentQuestionAnswers[index]}');
                      if (_currentQuestionAnswers[index] ==
                          _currentQuestionCorrectAnswer) {
                        print('Correct answer!');
                        setState(() {
                          _earnedExperience += widget.difficulty == 'easy'
                              ? 1
                              : widget.difficulty == 'medium'
                                  ? 2
                                  : 3;
                        });
                      } else {
                        print('Wrong answer!');
                      }
                      setState(() {
                        _currentQuestion++;
                      });
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(_currentQuestionAnswers[index]),
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
