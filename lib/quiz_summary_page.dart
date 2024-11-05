import 'package:flutter/material.dart';

class QuizSummaryPage extends StatelessWidget {
  const QuizSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Summary'),
      ),
      body: const Center(
        child: Text('This is the quiz summary page.'),
      ),
    );
  }
}
