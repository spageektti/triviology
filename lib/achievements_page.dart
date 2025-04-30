/*
* achievements_page.dart - achievements page for the Triviology app.
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
import 'package:easy_localization/easy_localization.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({
    super.key,
    required this.easyCorrect,
    required this.easyTotal,
    required this.easyQuizes,
    required this.mediumCorrect,
    required this.mediumTotal,
    required this.mediumQuizes,
    required this.hardCorrect,
    required this.hardTotal,
    required this.hardQuizes,
    required this.totalExperience,
    required this.totalCorrect,
    required this.totalQuestions,
    required this.totalQuizes,
    required this.categoryName,
    required this.categoryIcon,
    required this.easyMaxCorrectAnswersStreak,
    required this.easyMaxIncorrectAnswersStreak,
    required this.mediumMaxCorrectAnswersStreak,
    required this.mediumMaxIncorrectAnswersStreak,
    required this.hardMaxCorrectAnswersStreak,
    required this.hardMaxIncorrectAnswersStreak,
  });

  final int easyCorrect;
  final int easyTotal;
  final int easyQuizes;
  final int mediumCorrect;
  final int mediumTotal;
  final int mediumQuizes;
  final int hardCorrect;
  final int hardTotal;
  final int hardQuizes;
  final int totalExperience;
  final int totalCorrect;
  final int totalQuestions;
  final int totalQuizes;
  final String categoryName;
  final Widget categoryIcon;
  final int easyMaxCorrectAnswersStreak;
  final int easyMaxIncorrectAnswersStreak;
  final int mediumMaxCorrectAnswersStreak;
  final int mediumMaxIncorrectAnswersStreak;
  final int hardMaxCorrectAnswersStreak;
  final int hardMaxIncorrectAnswersStreak;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Center(child: Text(context.tr("easy"), style: TextStyle(fontSize: 20))),
          ),
          ListTile(
            title: Text(context.tr("easy_correct_2"),
                style: TextStyle(
                    color: easyCorrect >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_correct_4"),
                style: TextStyle(
                    color: easyCorrect >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_correct_8"),
                style: TextStyle(
                    color: easyCorrect >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_correct_16"),
                style: TextStyle(
                    color: easyCorrect >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_correct_32"),
                style: TextStyle(
                    color: easyCorrect >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_correct_64"),
                style: TextStyle(
                    color: easyCorrect >= 64
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_correct_128"),
                style: TextStyle(
                    color: easyCorrect >= 128
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_correct_256"),
                style: TextStyle(
                    color: easyCorrect >= 256
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_50_percent_20"),
                style: TextStyle(
                    color:
                        easyCorrect / easyTotal * 100 >= 50 && easyTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_75_percent_20"),
                style: TextStyle(
                    color:
                        easyCorrect / easyTotal * 100 >= 75 && easyTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_100_percent_20"),
                style: TextStyle(
                    color:
                        easyCorrect / easyTotal * 100 >= 100 && easyTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          const ListTile(
            title: Center(child: Text('-------------------------')),
          ),
          ListTile(
            title: Text(context.tr("easy_streak_2_correct"),
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_4_correct"),
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_8_correct"),
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_16_correct"),
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_32_correct"),
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_2_incorrect"),
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_4_incorrect"),
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_8_incorrect"),
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_16_incorrect"),
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("easy_streak_32_incorrect"),
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title:
                Center(child: Text(context.tr("medium"), style: TextStyle(fontSize: 20))),
          ),
          ListTile(
            title: Text(context.tr("medium_correct_2"),
                style: TextStyle(
                    color: mediumCorrect >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_correct_4"),
                style: TextStyle(
                    color: mediumCorrect >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_correct_8"),
                style: TextStyle(
                    color: mediumCorrect >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_correct_16"),
                style: TextStyle(
                    color: mediumCorrect >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_correct_32"),
                style: TextStyle(
                    color: mediumCorrect >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_correct_64"),
                style: TextStyle(
                    color: mediumCorrect >= 64
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('context.tr("medium_correct_128")',
                style: TextStyle(
                    color: mediumCorrect >= 128
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_correct_256"),
                style: TextStyle(
                    color: mediumCorrect >= 256
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_50_percent_20"),
                style: TextStyle(
                    color: mediumCorrect / mediumTotal * 100 >= 50 &&
                            mediumTotal >= 20
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
            //trailing: const Text('2XP'),
          ),
          ListTile(
            title: Text(context.tr("medium_75_percent_20"),
                style: TextStyle(
                    color: mediumCorrect / mediumTotal * 100 >= 75 &&
                            mediumTotal >= 20
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_100_percent_20"),
                style: TextStyle(
                    color: mediumCorrect / mediumTotal * 100 >= 100 &&
                            mediumTotal >= 20
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          const ListTile(
            title: Center(child: Text('-------------------------')),
          ),
          ListTile(
            title: Text(context.tr("medium_streak_2_correct"),
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_4_correct"),
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_8_correct"),
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_16_correct"),
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_32_correct"),
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_2_incorrect"),
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_4_incorrect"),
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_8_incorrect"),
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_16_incorrect"),
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("medium_streak_32_incorrect"),
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Center(child: Text(context.tr("hard"), style: TextStyle(fontSize: 20))),
          ),
          ListTile(
            title: Text(context.tr("hard_correct_2"),
                style: TextStyle(
                    color: hardCorrect >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_correct_4"),
                style: TextStyle(
                    color: hardCorrect >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_correct_8"),
                style: TextStyle(
                    color: hardCorrect >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_correct_16"),
                style: TextStyle(
                    color: hardCorrect >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_correct_32"),
                style: TextStyle(
                    color: hardCorrect >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_correct_64"),
                style: TextStyle(
                    color: hardCorrect >= 64
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_correct_128"),
                style: TextStyle(
                    color: hardCorrect >= 128
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_correct_256"),
                style: TextStyle(
                    color: hardCorrect >= 256
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_50_percent_20"),
                style: TextStyle(
                    color:
                        hardCorrect / hardTotal * 100 >= 50 && hardTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
            //trailing: const Text('2XP'),
          ),
          ListTile(
            title: Text(context.tr("hard_75_percent_20"),
                style: TextStyle(
                    color:
                        hardCorrect / hardTotal * 100 >= 75 && hardTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_100_percent_20"),
                style: TextStyle(
                    color:
                        hardCorrect / hardTotal * 100 >= 100 && hardTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          const ListTile(
            title: Center(child: Text('-------------------------')),
          ),
          ListTile(
            title: Text(context.tr("hard_streak_2_correct"),
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_4_correct"),
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_8_correct"),
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_16_correct"),
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_32_correct"),
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_2_incorrect"),
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_4_incorrect"),
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_8_incorrect"),
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_16_incorrect"),
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("hard_streak_32_incorrect"),
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Center(child: Text(context.tr("all"), style: TextStyle(fontSize: 20))),
          ),
          ListTile(
            title: Text(context.tr("all_correct_2"),
                style: TextStyle(
                    color: totalCorrect >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_correct_4"),
                style: TextStyle(
                    color: totalCorrect >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_correct_8"),
                style: TextStyle(
                    color: totalCorrect >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_correct_16"),
                style: TextStyle(
                    color: totalCorrect >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_correct_32"),
                style: TextStyle(
                    color: totalCorrect >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_correct_64"),
                style: TextStyle(
                    color: totalCorrect >= 64
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_correct_128"),
                style: TextStyle(
                    color: totalCorrect >= 128
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_correct_256"),
                style: TextStyle(
                    color: totalCorrect >= 256
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_50_percent_20"),
                style: TextStyle(
                    color: totalCorrect / totalCorrect * 100 >= 50 &&
                            totalCorrect >= 20
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
            //trailing: const Text('2XP'),
          ),
          ListTile(
            title: Text(context.tr("all_75_percent_20"),
                style: TextStyle(
                    color: totalCorrect / totalQuestions * 100 >= 75 &&
                            totalQuestions >= 20
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text(context.tr("all_100_percent_20"),
                style: TextStyle(
                    color: totalCorrect / totalQuestions * 100 >= 100 &&
                            totalQuestions >= 20
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
        ],
      ),
    );
  }
}
