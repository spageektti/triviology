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
import 'package:triviology/database_settings_page.dart';
import 'package:easy_localization/easy_localization.dart';

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
              title: Text(context.tr("success")),
              content: Text(context.tr("quiz-results-cleared")),
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
                title: Text(context.tr("error")),
                content: Text(context.tr("nothing-to-clear")),
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
              title: Text(context.tr("success")),
              content: Text(context.tr("settings-cleared")),
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
                title: Text(context.tr("error")),
                content: Text(context.tr("no-settings-to-clear")),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("settings")),
      ),
      body: Center(
        child: /*Column(
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
         
        ],
      )*/
            ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.storage),
              title: Text(context.tr("question-database")),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return DatabaseSettings(
                    databaseCodename: widget.databaseCodename,
                  );
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: Text(context.tr("remove-data")),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(context.tr("remove-data")),
                      content: Text(
                        context.tr("choose-data"),
                        style: TextStyle(fontSize: 18),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            clearQuizResults();
                          },
                          child: Text(context.tr("quiz-results")),
                        ),
                        TextButton(
                          onPressed: () {
                            clearSettings();
                          },
                          child: Text(context.tr("settings")),
                        ),
                        TextButton(
                            onPressed: () {
                              clearQuizResults();
                              clearSettings();
                            },
                            child: Text(context.tr("all-data")))
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
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
