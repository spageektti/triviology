import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:triviology/navigation_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkAndCreateSettingsFile();
  String databaseJson = await File(
          '${(await getApplicationDocumentsDirectory()).path}/settings.json')
      .readAsString();
  final databaseSettings = jsonDecode(databaseJson);
  runApp(MyApp(
      databaseName: databaseSettings['databaseName'],
      databaseUrl: databaseSettings['databaseUrl'],
      databaseCodename: databaseSettings['databaseCodename'],
      databaseSavefile: databaseSettings['databaseSavefile']));
}

Future<void> checkAndCreateSettingsFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final settingsFile = File('${directory.path}/settings.json');

  if (!await settingsFile.exists()) {
    final settings = {
      'databaseName': 'Open Trivia Database API',
      'databaseCodename': 'opentdbapi',
      'databaseUrl': 'https://opentdb.com',
      'databaseSavefile': 'opentdb',
    };

    await settingsFile.writeAsString(jsonEncode(settings));
    print('settings.json created with default values.');
  } else {
    print('settings.json already exists.');
  }

  // check if all neccessary keys are present
  final settingsJson = jsonDecode(await settingsFile.readAsString());
  final defaultSettings = {
    'databaseName': 'Open Trivia Database API',
    'databaseCodename': 'opentdbapi',
    'databaseUrl': 'https://opentdb.com',
    'databaseSavefile': 'opentdb',
  };

  bool needsUpdate = false;
  defaultSettings.forEach((key, value) {
    if (!settingsJson.containsKey(key)) {
      settingsJson[key] = value;
      needsUpdate = true;
    }
  });

  if (needsUpdate) {
    await settingsFile.writeAsString(jsonEncode(settingsJson));
    print('settings.json updated with missing keys.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.databaseName,
      required this.databaseUrl,
      required this.databaseCodename,
      required this.databaseSavefile});

  final String databaseName;
  final String databaseUrl;
  final String databaseCodename;
  final String databaseSavefile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Triviology',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)),
      darkTheme: ThemeData.dark(),
      home: NavigationWidget(
          databaseName: databaseName,
          databaseUrl: databaseUrl,
          databaseCodename: databaseCodename,
          databaseSavefile: databaseSavefile),
      debugShowCheckedModeBanner: false,
    );
  }
}
