/*
* settings_page.dart - page where user can customize their experience with the app.
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
import 'package:triviology/download_page.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(
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
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _downloadedDatabases = <DropdownMenuItem<String>>[
    const DropdownMenuItem(
      value: 'loading...',
      child: Text('loading...'),
    ),
  ];
  bool _downloadedDatabasesLoaded = false;
  late String _selectedDatabase;

  @override
  void initState() {
    super.initState();
    _selectedDatabase = '${widget.databaseCodename}.json';
  }

  Future<void> clearQuizResults() async {
    final directory = await getApplicationDocumentsDirectory();
    final quizResultsFile = File('${directory.path}/save.json');

    if (await quizResultsFile.exists()) {
      await quizResultsFile.delete();
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Quiz results have been cleared.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      if (mounted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('No quiz results to clear.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    }
  }

  Future<void> clearSettings() async {
    final directory = await getApplicationDocumentsDirectory();
    final settingsFile = File('${directory.path}/settings.json');

    if (await settingsFile.exists()) {
      await settingsFile.delete();
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Settings have been cleared.'),
              actions: <Widget>[
                TextButton(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.refresh),
                      Text('Reload'),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      if (mounted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('No settings to clear.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    }
  }

  Future<void> loadDatabases() async {
    final directory = await getApplicationDocumentsDirectory();
    final databases = <DropdownMenuItem<String>>[];

    final files = directory.listSync();
    for (var file in files) {
      if (file.path.endsWith('.json') &&
          !file.path.endsWith('save.json') &&
          !file.path.endsWith('settings.json')) {
        final database = file.path.split('/').last;
        databases.add(DropdownMenuItem(
          value: database,
          child: Text(database),
        ));
      }
    }

    setState(() {
      _downloadedDatabases.clear();
      _downloadedDatabases.addAll(databases);
      _downloadedDatabasesLoaded = true;
    });
  }

  Future<void> updateSelectedDatabase(String database) async {
    final directory = await getApplicationDocumentsDirectory();
    final settingsFile = File('${directory.path}/settings.json');
    if (!await settingsFile.exists()) {
      await settingsFile.create();
      await settingsFile.writeAsString('{}');
    }
    final settingsJson = await settingsFile.readAsString();
    final settings = jsonDecode(settingsJson);
    final databaseFile = File('${directory.path}/$database');
    final databaseJson = await databaseFile.readAsString();
    final databaseSettings = jsonDecode(databaseJson);

    settings['databaseName'] = databaseSettings['name'];
    settings['databaseCodename'] = databaseSettings['codename'];
    settings['databaseSavefile'] = databaseSettings['savefile'];
    settings['databaseUrl'] = databaseSettings['url'];

    await settingsFile.writeAsString(jsonEncode(settings));

    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text(
                'Settings have been updated. Please close the app and launch it again to apply the changes.'),
            actions: <Widget>[
              TextButton(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.close_rounded),
                    Text('Close the app'),
                  ],
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_downloadedDatabasesLoaded == false) {
      loadDatabases();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
          child: Column(
        children: [
          const Text('Select question source'),
          if (_downloadedDatabasesLoaded)
            DropdownButton<String>(
              items: _downloadedDatabases,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDatabase = newValue as String;
                });
              },
              value: _selectedDatabase,
              hint: const Text('Select question source'),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                updateSelectedDatabase(_selectedDatabase);
              },
              child: const Text('Save new settings')),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                clearQuizResults();
              },
              child: const Text('Clear saved quiz results')),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                clearSettings();
              },
              child: const Text('Clear settings'))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const DownloadPage();
          }));
        },
        child: const Icon(Icons.cloud_download_outlined),
      ),
    );
  }
}
