/*
* database_settings_page.dart - a page to manage the database settings, like the current selected database.
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
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

class DatabaseSettings extends StatefulWidget {
  const DatabaseSettings({super.key, required this.databaseCodename});

  final String databaseCodename;

  @override
  _DatabaseSettingsState createState() => _DatabaseSettingsState();
}

class _DatabaseSettingsState extends State<DatabaseSettings> {
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

  Future<void> loadDatabases() async {
    final directory = await getApplicationDocumentsDirectory();
    final databases = <DropdownMenuItem<String>>[];

    final files = directory.listSync();
    for (var file in files) {
      if (file.path.endsWith('.json') &&
          !file.path.endsWith('save.json') &&
          !file.path.endsWith('settings.json')) {
        final databaseFile = File(file.path);
        final databaseJson = await databaseFile.readAsString();
        final databaseSettings = jsonDecode(databaseJson);
        final databaseName = databaseSettings['name'];
        final database = file.path.split('/').last;
        databases.add(DropdownMenuItem(
          value: database,
          child: Text(databaseName),
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
        title: Text('Database Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                updateSelectedDatabase(_selectedDatabase);
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
