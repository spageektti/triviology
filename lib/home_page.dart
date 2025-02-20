/*
* home_page.dart - page where you can start the quiz.
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
import 'package:triviology/quiz_settings_page.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:triviology/icon_mapper.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.databaseName,
      required this.databaseUrl,
      required this.databaseCodename,
      required this.databaseSavefile});

  final String databaseName;
  final String databaseUrl;
  final String databaseCodename;
  final String databaseSavefile;
  final String apiUrl = "";
  final String questions = "";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.question_answer, 'text': 'General Knowledge', 'id': 9},
    {'icon': Icons.book, 'text': 'Books', 'id': 10},
    {'icon': Icons.movie, 'text': 'Film', 'id': 11},
    {'icon': Icons.headphones, 'text': 'Music', 'id': 12},
    {'icon': Icons.theater_comedy, 'text': 'Musicals & Theatres', 'id': 13},
    {'icon': Icons.tv, 'text': 'Television', 'id': 14},
    {'icon': Icons.videogame_asset, 'text': 'Video Games', 'id': 15},
    {'icon': Icons.extension, 'text': 'Board Games', 'id': 16},
    {'icon': Icons.science_rounded, 'text': 'Science & Nature', 'id': 17},
    {'icon': Icons.computer, 'text': 'Computers', 'id': 18},
    {'icon': Icons.calculate, 'text': 'Mathematics', 'id': 19},
    {'icon': Icons.menu_book, 'text': 'Mythology', 'id': 20},
    {'icon': Icons.sports, 'text': 'Sports', 'id': 21},
    {'icon': Icons.map, 'text': 'Geography', 'id': 22},
    {'icon': Icons.history_edu, 'text': 'History', 'id': 23},
    {'icon': Icons.how_to_vote, 'text': 'Politics', 'id': 24},
    {'icon': Icons.brush, 'text': 'Art', 'id': 25},
    {'icon': Icons.star, 'text': 'Celebrities', 'id': 26},
    {'icon': Icons.pets, 'text': 'Animals', 'id': 27},
    {'icon': Icons.directions_car, 'text': 'Vehicles', 'id': 28},
    {'icon': Icons.my_library_books, 'text': 'Comics', 'id': 29},
    {'icon': Icons.devices_other, 'text': 'Gadgets', 'id': 30},
    {'icon': Icons.face, 'text': 'Japanese Anime & Manga', 'id': 31},
    {'icon': Icons.animation, 'text': 'Cartoon & Animations', 'id': 32},
  ];
  bool _categoriesLoaded = false;
  String _databaseType = "";
  String _apiUrl = "";
  String _questions = "";
  String _questionCount = "";

  Future<void> loadCategories() async {
    final directory = await getApplicationDocumentsDirectory();
    final databaseJson =
        File('${directory.path}/${widget.databaseCodename}.json');
    if (await databaseJson.exists()) {
      final database = await databaseJson.readAsString();
      final decodedJson = jsonDecode(database);
      final categories = decodedJson['categories'];
      final databaseType = decodedJson['type'];
      final apiUrl = databaseType == "api" ? decodedJson['api_url'] : "None";
      final booleanQuestions =
          databaseType != "api" ? decodedJson['questions_boolean'] : "{}";
      final multipleQuestions =
          databaseType != "api" ? decodedJson['questions_multiple'] : "{}";
      final questions = {
        'boolean': booleanQuestions,
        'multiple': multipleQuestions,
      };
      final questionCount =
          databaseType != "api" ? decodedJson['question_count'] : "{}";
      print(categories);
      setState(() {
        _categories.clear();
        _categories
            .addAll(List<Map<String, dynamic>>.from(categories.map((category) {
          return {
            'icon': getIconData(category['icon']),
            'text': category['text'],
            'id': category['id'],
          };
        })));
        _databaseType = databaseType;
        _apiUrl = apiUrl;
        _questions = jsonEncode(questions);
        _questionCount = jsonEncode(questionCount);
        _categoriesLoaded = true;
        print(_databaseType);
        print(_questions);
      });
    } else {
      setState(() {
        _categoriesLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_categoriesLoaded) {
      loadCategories();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a category'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Information'),
                    content: Column(
                      children: [
                        const Text(
                            'App made with love by Wiktor Perskawiec (@spageektti)'),
                        const Text(
                            'The app\'s source code is available on GitHub'),
                        const Text(
                            'The app is licensed under the GPLv3 License'),
                        Text('Database used: ${widget.databaseName}'),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(onPressed: () {}, child: const Text('GitHub')),
                      TextButton(
                          onPressed: () {},
                          child: const Text('License (GPLv3)')),
                      TextButton(
                          onPressed: () {}, child: const Text('Database')),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: _categoriesLoaded
          ? GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Category with id: ${category['id']} tapped.');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return QuizSettingsPage(
                            categoryId: category['id'],
                            categoryName: category['text'],
                            databaseName: widget.databaseName,
                            databaseUrl: widget.databaseUrl,
                            databaseCodename: widget.databaseCodename,
                            databaseSavefile: widget.databaseSavefile,
                            databaseType: _databaseType,
                            apiUrl: _apiUrl,
                            questions: _questions,
                            questionCount: _questionCount);
                      }));
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(category['icon'], size: 50),
                          Text(
                            category['text'],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
