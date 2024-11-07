import 'package:flutter/material.dart';
import 'package:triviology/navigation_widget.dart';

class QuizSummaryPage extends StatelessWidget {
  const QuizSummaryPage({
    super.key,
    required this.categoryName,
    required this.numOfQuestions,
    required this.difficulty,
    required this.questionType,
    required this.earnedExperience,
    required this.correctlyAnsweredQuestions,
    required this.databaseName,
    required this.databaseUrl,
    required this.databaseCodename,
    required this.databaseSavefile,
  });

  final String categoryName;
  final int numOfQuestions;
  final String difficulty;
  final String questionType;
  final int earnedExperience;
  final int correctlyAnsweredQuestions;
  final String databaseName;
  final String databaseUrl;
  final String databaseCodename;
  final String databaseSavefile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('$earnedExperience XP'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Text(
              difficulty[0].toUpperCase(),
              style: TextStyle(
                  color: difficulty == 'easy'
                      ? Colors.greenAccent
                      : difficulty == 'medium'
                          ? Colors.orangeAccent
                          : Colors.redAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              questionType[0].toUpperCase(),
              style: TextStyle(
                  color: questionType == 'multiple'
                      ? Colors.blueAccent
                      : questionType == 'boolean'
                          ? Colors.purpleAccent
                          : Colors.yellowAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('$numOfQuestions/$numOfQuestions'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(
                children: [
                  const Text('Congratulations!',
                      style: TextStyle(fontSize: 30)),
                  const Text('You have completed the quiz!',
                      style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: SizedBox(
                      height: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: correctlyAnsweredQuestions / numOfQuestions,
                          backgroundColor: Colors.white,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Text('${correctlyAnsweredQuestions / numOfQuestions * 100}%'),
                ],
              ),
            ),
            const Text(
                'We updated your data. You can now view your stats in the Profile tab.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.home),
          onPressed: () {
            print('pressed');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => NavigationWidget(
                  databaseName: databaseName,
                  databaseUrl: databaseUrl,
                  databaseCodename: databaseCodename,
                  databaseSavefile: databaseSavefile,
                ),
              ),
              (route) => false,
            );
          }),
    );
  }
}
