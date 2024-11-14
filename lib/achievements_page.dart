import 'package:flutter/material.dart';

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
          const ListTile(
            title: Center(child: Text('Easy', style: TextStyle(fontSize: 20))),
          ),
          ListTile(
            title: Text('Correctly answer 2 easy questions',
                style: TextStyle(
                    color: easyCorrect >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 4 easy questions',
                style: TextStyle(
                    color: easyCorrect >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 8 easy questions',
                style: TextStyle(
                    color: easyCorrect >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 16 easy questions',
                style: TextStyle(
                    color: easyCorrect >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 32 easy questions',
                style: TextStyle(
                    color: easyCorrect >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 64 easy questions',
                style: TextStyle(
                    color: easyCorrect >= 64
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 128 easy questions',
                style: TextStyle(
                    color: easyCorrect >= 128
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 256 easy questions',
                style: TextStyle(
                    color: easyCorrect >= 256
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 50% of at least 20 easy questions',
                style: TextStyle(
                    color:
                        easyCorrect / easyTotal * 100 >= 50 && easyTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 75% of at least 20 easy questions',
                style: TextStyle(
                    color:
                        easyCorrect / easyTotal * 100 >= 75 && easyTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 100% of at least 20 easy questions',
                style: TextStyle(
                    color:
                        easyCorrect / easyTotal * 100 >= 50 && easyTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          const ListTile(
            title: Center(child: Text('-------------------------')),
          ),
          ListTile(
            title: Text('Correctly answer 2 easy questions in a row',
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 4 easy questions in a row',
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 8 easy questions in a row',
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 16 easy questions in a row',
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 32 easy questions in a row',
                style: TextStyle(
                    color: easyMaxCorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 2 easy questions in a row',
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 4 easy questions in a row',
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 8 easy questions in a row',
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 16 easy questions in a row',
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 32 easy questions in a row',
                style: TextStyle(
                    color: easyMaxIncorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          const ListTile(
            title:
                Center(child: Text('Medium', style: TextStyle(fontSize: 20))),
          ),
          ListTile(
            title: Text('Correctly answer 2 medium questions',
                style: TextStyle(
                    color: mediumCorrect >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 4 medium questions',
                style: TextStyle(
                    color: mediumCorrect >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 8 medium questions',
                style: TextStyle(
                    color: mediumCorrect >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 16 medium questions',
                style: TextStyle(
                    color: mediumCorrect >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 32 medium questions',
                style: TextStyle(
                    color: mediumCorrect >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 64 medium questions',
                style: TextStyle(
                    color: mediumCorrect >= 64
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 128 medium questions',
                style: TextStyle(
                    color: mediumCorrect >= 128
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 256 medium questions',
                style: TextStyle(
                    color: mediumCorrect >= 256
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 50% of at least 20 medium questions',
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
            title: Text('Correctly answer 75% of at least 20 medium questions',
                style: TextStyle(
                    color: mediumCorrect / mediumTotal * 100 >= 75 &&
                            mediumTotal >= 20
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 100% of at least 20 medium questions',
                style: TextStyle(
                    color: mediumCorrect / mediumTotal * 100 >= 50 &&
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
            title: Text('Correctly answer 2 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 4 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 8 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 16 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 32 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxCorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 2 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 4 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 8 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 16 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 32 medium questions in a row',
                style: TextStyle(
                    color: mediumMaxIncorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          const ListTile(
            title: Center(child: Text('Hard', style: TextStyle(fontSize: 20))),
          ),
          ListTile(
            title: Text('Correctly answer 2 hard questions',
                style: TextStyle(
                    color: hardCorrect >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 4 hard questions',
                style: TextStyle(
                    color: hardCorrect >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 8 hard questions',
                style: TextStyle(
                    color: hardCorrect >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 16 hard questions',
                style: TextStyle(
                    color: hardCorrect >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 32 hard questions',
                style: TextStyle(
                    color: hardCorrect >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 64 hard questions',
                style: TextStyle(
                    color: hardCorrect >= 64
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 128 hard questions',
                style: TextStyle(
                    color: hardCorrect >= 128
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 256 hard questions',
                style: TextStyle(
                    color: hardCorrect >= 256
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 50% of at least 20 hard questions',
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
            title: Text('Correctly answer 75% of at least 20 hard questions',
                style: TextStyle(
                    color:
                        hardCorrect / hardTotal * 100 >= 75 && hardTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 100% of at least 20 hard questions',
                style: TextStyle(
                    color:
                        hardCorrect / hardTotal * 100 >= 50 && hardTotal >= 20
                            ? Colors.green
                            : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          const ListTile(
            title: Center(child: Text('-------------------------')),
          ),
          ListTile(
            title: Text('Correctly answer 2 hard questions in a row',
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 4 hard questions in a row',
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 8 hard questions in a row',
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 16 hard questions in a row',
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 32 hard questions in a row',
                style: TextStyle(
                    color: hardMaxCorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 2 hard questions in a row',
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 4 hard questions in a row',
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 8 hard questions in a row',
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 16 hard questions in a row',
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Incorrectly answer 32 hard questions in a row',
                style: TextStyle(
                    color: hardMaxIncorrectAnswersStreak >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          const ListTile(
            title: Center(child: Text('All', style: TextStyle(fontSize: 20))),
          ),
          ListTile(
            title: Text('Correctly answer 2 questions',
                style: TextStyle(
                    color: totalCorrect >= 2
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 4 questions',
                style: TextStyle(
                    color: totalCorrect >= 4
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 8 questions',
                style: TextStyle(
                    color: totalCorrect >= 8
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 16 questions',
                style: TextStyle(
                    color: totalCorrect >= 16
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 32 questions',
                style: TextStyle(
                    color: totalCorrect >= 32
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 64 questions',
                style: TextStyle(
                    color: totalCorrect >= 64
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 128 questions',
                style: TextStyle(
                    color: totalCorrect >= 128
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 256 questions',
                style: TextStyle(
                    color: totalCorrect >= 256
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 50% of at least 20 questions',
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
            title: Text('Correctly answer 75% of at least 20 questions',
                style: TextStyle(
                    color: totalCorrect / totalQuestions * 100 >= 75 &&
                            totalQuestions >= 20
                        ? Colors.green
                        : Theme.of(context).listTileTheme.textColor)),
            subtitle: Text(categoryName),
            leading: categoryIcon,
          ),
          ListTile(
            title: Text('Correctly answer 100% of at least 20 questions',
                style: TextStyle(
                    color: totalCorrect / totalQuestions * 100 >= 50 &&
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
