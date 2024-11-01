import 'package:flutter/material.dart';

final List<Map<String, dynamic>> categories = [
  {'icon': Icons.question_answer, 'text': 'General Knowledge'},
  {'icon': Icons.book, 'text': 'Books'},
  {'icon': Icons.movie, 'text': 'Film'},
  {'icon': Icons.headphones, 'text': 'Music'},
  {'icon': Icons.theater_comedy, 'text': 'Musicals & Theatres'},
  {'icon': Icons.tv, 'text': 'Television'},
  {'icon': Icons.videogame_asset, 'text': 'Video Games'},
  {'icon': Icons.extension, 'text': 'Board Games'},
  {'icon': Icons.nature, 'text': 'Science & Nature'},
  {'icon': Icons.computer, 'text': 'Computers'},
  {'icon': Icons.calculate, 'text': 'Mathematics'},
  {'icon': Icons.menu_book, 'text': 'Mythology'},
  {'icon': Icons.sports, 'text': 'Sports'},
  {'icon': Icons.map, 'text': 'Geography'},
  {'icon': Icons.history_edu, 'text': 'History'},
  {'icon': Icons.how_to_vote, 'text': 'Politics'},
  {'icon': Icons.brush, 'text': 'Art'},
  {'icon': Icons.star, 'text': 'Celebrities'},
  {'icon': Icons.pets, 'text': 'Animals'},
  {'icon': Icons.directions_car, 'text': 'Vehicles'},
  {'icon': Icons.my_library_books, 'text': 'Comics'},
  {'icon': Icons.devices_other, 'text': 'Gadgets'},
  {'icon': Icons.face, 'text': 'Japanese Anime & Manga'},
  {'icon': Icons.animation, 'text': 'Cartoon & Animations'},
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print('${category['text']} tapped.');
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(category['icon'], size: 50),
                    Text(category['text']),
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
