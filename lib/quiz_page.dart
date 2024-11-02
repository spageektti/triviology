import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.categoryId});

  final int categoryId;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Knowledge'),
      ),
      body: const Center(
        child: Text('This is the quiz page'),
      ),
    );
  }
}
