import 'package:flutter/material.dart';
import 'package:triviology/quiz_summary_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  int _currentQuestion = 0;
  int _earnedExperience = 0;
  final String _currentQuestionType =
      'multiple'; // TODO: check if it is even needed
  List<dynamic> _currentQuestionAnswers = [
    'Italy',
    'Paris',
    'Warsaw',
    'I dont know I am from USA'
  ];
  String _currentQuestionCorrectAnswer = 'Paris';
  String _currentQuestionBody = 'What is the capital of France?';
  // example JSON from API call to Open Trivia DB
  Map<String, dynamic>?
      _decodedJson; /*jsonDecode(
      '');*/ /*'''{
  "response_code": 0,
  "results": [
    {
      "type": "multiple",
      "difficulty": "medium",
      "category": "History",
      "question": "In what year did the First World War end?",
      "correct_answer": "1918",
      "incorrect_answers": [
        "1914",
        "1916",
        "1912"
      ]
    },
    {
      "type": "multiple",
      "difficulty": "easy",
      "category": "General Knowledge",
      "question": "In DC comics where does the Green Arrow (Oliver Queen) live?",
      "correct_answer": "Star City",
      "incorrect_answers": [
        "Central City",
        "Gotham City",
        "Metropolis"
      ]
    },
    {
      "type": "boolean",
      "difficulty": "easy",
      "category": "Entertainment: Music",
      "question": "American rapper Dr. Dre actually has a Ph.D. doctorate.",
      "correct_answer": "False",
      "incorrect_answers": [
        "True"
      ]
    },
    {
      "type": "multiple",
      "difficulty": "medium",
      "category": "Science: Mathematics",
      "question": "What shape does sin(x) or cos(x) make on a graph?",
      "correct_answer": "Waves",
      "incorrect_answers": [
        "A Parabola",
        "A Straight Line",
        "Zig-Zags"
      ]
    },
    {
      "type": "boolean",
      "difficulty": "easy",
      "category": "Entertainment: Video Games",
      "question": "Codemasters is the developer of the Gran Turismo series.",
      "correct_answer": "False",
      "incorrect_answers": [
        "True"
      ]
    }
  ]
}
''');*/
  // !there is probably a bug somewhere in this code, because some categories return errors
  // TODO: read API docs to learn what these errors mean and how to handle them
  Future<void> _fetchQuestions() async {
    String url =
        "https://opentdb.com/api.php?amount=${widget.numOfQuestions}&category=${widget.categoryId}&difficulty=${widget.difficulty}";
    if (widget.questionType != 'any') {
      url +=
          '&type=${widget.questionType}'; // Fixed the typo from \$type to &type
    }

    try {
      http.Response response = await http.get(Uri.parse(url));
      //print(response.body); // - do not uncomment unless needed - it will spam your console - actually I am writing it to my self because I dont think anyone else will ever read this - I actually enjoy writing comments xd

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);

        if (decodedJson['response_code'] == 0) {
          setState(() {
            _decodedJson = decodedJson;
          });
        } else {
          print('Error: Response code ${decodedJson['response_code']}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_decodedJson == null) {
      _fetchQuestions();
    } else {
      setState(() {
        _currentQuestionBody =
            _decodedJson?['results'][_currentQuestion]['question'];
        _currentQuestionAnswers = _decodedJson?['results'][_currentQuestion]
                ['incorrect_answers'] +
            [_decodedJson?['results'][_currentQuestion]['correct_answer']];
        _currentQuestionCorrectAnswer =
            _decodedJson?['results'][_currentQuestion]['correct_answer'];
      });
    }
    // I have NO IDEA how to add loading screen here, but I need to do something about the delay in fetching the questions
    // TODO: add loading screen
    // I am actually gonna create a github issue for this so I dont forget about it
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('$_earnedExperience XP'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Text(
              widget.difficulty[0].toUpperCase(),
              style: TextStyle(
                  color: widget.difficulty == 'easy'
                      ? Colors.greenAccent
                      : widget.difficulty == 'medium'
                          ? Colors.orangeAccent
                          : Colors.redAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              widget.questionType[0].toUpperCase(),
              style: TextStyle(
                  color: widget.questionType == 'multiple'
                      ? Colors.blueAccent
                      : widget.questionType == 'boolean'
                          ? Colors.purpleAccent
                          : Colors.yellowAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('$_currentQuestion/${widget.numOfQuestions}'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_currentQuestionBody, style: const TextStyle(fontSize: 20)),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _currentQuestionAnswers.length,
              itemBuilder: (context, index) {
                /*return InkWell(
                  onTap: () {
                    // do something xd
                  },
                  child: Card(
                    color: Colors.blueAccent,
                    child: Center(
                      child: Text(
                        _currentQuestionAnswers[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );*/
                return Card(
                  child: InkWell(
                    splashColor: _currentQuestionAnswers[index] ==
                            _currentQuestionCorrectAnswer
                        ? Colors.green.withAlpha(30)
                        : Colors.red.withAlpha(30),
                    onTapDown: (details) {
                      // changed from onTap to onTapDown to prevent cheating by canceling the tap
                      //print('Answer tapped: ${_currentQuestionAnswers[index]}');
                      Future.delayed(const Duration(milliseconds: 600), () {
                        setState(() {
                          _currentQuestion++;
                        });
                      });
                      if (_currentQuestionAnswers[index] ==
                          _currentQuestionCorrectAnswer) {
                        //print('Correct answer!');
                        setState(() {
                          _earnedExperience += widget.difficulty == 'easy'
                              ? 1
                              : widget.difficulty == 'medium'
                                  ? 2
                                  : 3;
                        });
                      } else {
                        //print('Wrong answer!');
                      }
                      if (_currentQuestion == widget.numOfQuestions - 1) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const QuizSummaryPage()),
                            (route) => false);
                      }
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(_currentQuestionAnswers[index] as String),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
