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

  // download the default database configuration (opentdbapi)
  // it fetches the JSON from GitHub
  final databaseJson = File('${directory.path}/opentdbapi.json');

  if (!await databaseJson.exists()) {
    const url =
        "https://raw.githubusercontent.com/triviology/opentdbapi/main/opentdbapi.json";
    final response = await HttpClient().getUrl(Uri.parse(url));
    final download = await response.close();
    await databaseJson
        .writeAsBytes(await download.expand((element) => element).toList());
    print('opentdbapi.json downloaded.');
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
