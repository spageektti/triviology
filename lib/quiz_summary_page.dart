/*
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
import 'package:triviology/navigation_widget.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> saveData(totalQuestions, correctAnswers, experience, categoryIdint,
    difficultyLevel, databaseSavefile) async {
  final directory = await getApplicationDocumentsDirectory();
  final saveFile = File('${directory.path}/save.json');
  final categoryId = categoryIdint.toString();

  if (await saveFile.exists()) {
    final saveJson = jsonDecode(await saveFile.readAsString());

    if (saveJson[databaseSavefile] == null) {
      saveJson[databaseSavefile] = {};
    }

    if (saveJson[databaseSavefile][categoryId] == null) {
      saveJson[databaseSavefile][categoryId] = {
        'easy': {
          'totalquestions': 0,
          'correctanswers': 0,
          'experience': 0,
          'totalquizzes': 0
        },
        'medium': {
          'totalquestions': 0,
          'correctanswers': 0,
          'experience': 0,
          'totalquizzes': 0
        },
        'hard': {
          'totalquestions': 0,
          'correctanswers': 0,
          'experience': 0,
          'totalquizzes': 0
        },
      };
    }

    if (saveJson[databaseSavefile][categoryId][difficultyLevel] == null) {
      saveJson[databaseSavefile][categoryId][difficultyLevel] = {
        'totalquestions': 0,
        'correctanswers': 0,
        'experience': 0,
        'totalquizzes': 0,
      };
    }

    saveJson[databaseSavefile][categoryId][difficultyLevel]['totalquestions'] +=
        totalQuestions;
    saveJson[databaseSavefile][categoryId][difficultyLevel]['correctanswers'] +=
        correctAnswers;
    saveJson[databaseSavefile][categoryId][difficultyLevel]['experience'] +=
        experience;
    saveJson[databaseSavefile][categoryId][difficultyLevel]['totalquizzes'] +=
        1;

    await saveFile.writeAsString(jsonEncode(saveJson));
  } else {
    await saveFile.writeAsString(jsonEncode({
      databaseSavefile: {
        categoryId: {
          'easy': {
            'totalquestions': totalQuestions,
            'correctanswers': correctAnswers,
            'experience': experience,
            'totalquizzes': 1
          },
          'medium': {
            'totalquestions': 0,
            'correctanswers': 0,
            'experience': 0,
            'totalquizzes': 0
          },
          'hard': {
            'totalquestions': 0,
            'correctanswers': 0,
            'experience': 0,
            'totalquizzes': 0
          },
        }
      }
    }));
  }
}

class QuizSummaryPage extends StatelessWidget {
  const QuizSummaryPage({
    super.key,
    required this.categoryName,
    required this.categoryId,
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
  final int categoryId;
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
    saveData(numOfQuestions, correctlyAnsweredQuestions, earnedExperience,
        categoryId, difficulty, databaseSavefile);
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
                  Text(
                      '${(correctlyAnsweredQuestions / numOfQuestions * 100).toStringAsFixed(2)}%'),
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
