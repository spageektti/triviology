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
  final int _currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('$_currentQuestion/${widget.numOfQuestions}'),
          ),
        ],
      ),
      body: const Center(
        child: Text('This is the quiz page'),
      ),
    );
  }
}
