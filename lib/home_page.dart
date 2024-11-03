import 'package:flutter/material.dart';
import 'package:triviology/quiz_settings_page.dart';

final List<Map<String, dynamic>> categories = [
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
  {'icon': Icons.devices_other, 'text': 'Gadgets', 'id': 10},
  {'icon': Icons.face, 'text': 'Japanese Anime & Manga', 'id': 31},
  {'icon': Icons.animation, 'text': 'Cartoon & Animations', 'id': 32},
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a category'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              print('Info button tapped.');
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print('Category with id: ${category['id']} tapped.');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return QuizSettingsPage(
                      categoryId: category['id'],
                      categoryName: category['text']);
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
      ),
    );
  }
}