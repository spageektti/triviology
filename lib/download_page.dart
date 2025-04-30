/*
* download_page.dart - page to download new databases.
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
import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class DownloadItem {
  final String name;
  final String description;
  final String githubOrg;
  final String githubRepo;
  final String language;
  final String flag;
  final String version;
  final String copyright;

  DownloadItem(
      {required this.name,
      required this.description,
      required this.githubOrg,
      required this.githubRepo,
      required this.language,
      required this.flag,
      required this.version,
      required this.copyright});
}

// * to add your dataset to the list, add a new DownloadItem to the list below
// * the DownloadItem class is defined above
// * only github releases are supported (you need to update this every version)
// * the list is pre-defined here instead of being fetched from a server (at least for now)
// TODO: add feature to user custom datasets
final List<DownloadItem> downloadItems = [
  DownloadItem(
      name: 'Główna Baza Pytań',
      description:
          'Baza pytań przygotowana przez autora aplikacji',
      githubOrg: 'triviology',
      githubRepo: 'mainquestiondbpl',
      version: 'v1.0.0',
      language: 'Polish',
      flag: 'PL',
      copyright: 'CC BY-SA 4.0 opentdb.com'),
  DownloadItem(
      name: 'Open Trivia Database API',
      description:
          'The Open Trivia Database API provides questions for 24 categories, with 3 difficulty levels, and 2 question types (multiple choice and true/false). It requires internet access tho.',
      githubOrg: 'triviology',
      githubRepo: 'opentdbapi',
      version: 'v1.0.1',
      language: 'English',
      flag: 'GB',
      copyright: 'CC BY-SA 4.0 opentdb.com'),
  DownloadItem(
      name: 'Test Database',
      description: 'To test triviology features. No real questions.',
      githubOrg: 'triviology',
      githubRepo: 'test-database',
      version: 'v1.0.0',
      language: 'English',
      flag: 'GB',
      copyright: 'None'),
];

class _DownloadPageState extends State<DownloadPage> {
  final List<bool> _isDownloaded = List.filled(downloadItems.length, false);
  final List<bool> _needsUpdate = List.filled(downloadItems.length, false);
  bool _generatedDownloadStatus = false;

  Future<void> generateDownloadStatus() async {
    for (int i = 0; i < downloadItems.length; i++) {
      final directory = await getApplicationDocumentsDirectory();
      final downloadJson =
          File('${directory.path}/${downloadItems[i].githubRepo}.json');
      if (await downloadJson.exists()) {
        final content = await downloadJson.readAsString();
        final jsonData = jsonDecode(content);
        setState(() {
          _isDownloaded[i] = true;
          if (jsonData['version'] != downloadItems[i].version) {
            _needsUpdate[i] = true;
          }
        });
      }
    }
    setState(() {
      _generatedDownloadStatus = true;
    });
  }

  Future<void> downloadItem(index) async {
    final url =
        'https://github.com/${downloadItems[index].githubOrg}/${downloadItems[index].githubRepo}/releases/download/${downloadItems[index].version}/${downloadItems[index].githubRepo}.json';
    print(url);
    final directory = await getApplicationDocumentsDirectory();
    final downloadJson =
        File('${directory.path}/${downloadItems[index].githubRepo}.json');
    final request = await HttpClient().getUrl(Uri.parse(url));
    final response = await request.close();
    final downloadContent = await response.transform(utf8.decoder).join();
    if (response.statusCode == 404 ||
        (downloadContent) == '{"error":"Not Found"}') {
      // Display error dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.tr("download-failed")),
              content: Text(
                  context.tr("download-failed-text")),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }

      return;
    }
    if (await downloadJson.exists()) {
      await downloadJson.delete();
    }
    await downloadJson.writeAsString(downloadContent);
    setState(() {
      _isDownloaded[index] = true;
      _needsUpdate[index] = false;
    });
    showInfoDialog(index);
  }

  Future<void> deleteItem(index) async {
    final directory = await getApplicationDocumentsDirectory();
    final downloadJson =
        File('${directory.path}/${downloadItems[index].githubRepo}.json');
    //check if there is any other database installed based on the _isDownloaded list
    await downloadJson.delete();
    if (_isDownloaded.where((element) => element).length == 1) {
      // Display error dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.tr("delete-failed")),
              content:  Text(
                context.tr("delete-failed-text")
                  ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
      return;
    }
    setState(() {
      _isDownloaded[index] = false;
      _needsUpdate[index] = false;
    });
    showInfoDialog(index);
  }

  showInfoDialog(index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            downloadItems[index].name,
            style: TextStyle(
              color: _isDownloaded[index]
                  ? Colors.green
                  : Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(downloadItems[index].description),
              const SizedBox(height: 16),
              Text(
                  'GitHub: ${downloadItems[index].githubOrg}/${downloadItems[index].githubRepo}'),
              Text('${context.tr("version")}: ${downloadItems[index].version}'),
              Row(
                children: [
                  Text('${context.tr("language")}: '),
                  CountryFlag.fromCountryCode(
                    downloadItems[index].flag,
                    shape: const RoundedRectangle(4),
                    width: 18,
                    height: 12,
                  ),
                  Text(' ${downloadItems[index].language}'),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(downloadItems[index].copyright),
            ],
          ),
          actions: [
            Wrap(
              alignment: WrapAlignment.end,
              direction: Axis.horizontal,
              spacing: 8.0,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_isDownloaded[index])
                      TextButton(
                        onPressed: () {
                          deleteItem(index);
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete_forever_rounded),
                            Text(context.tr("delete")),
                          ],
                        ),
                      ),
                    if ((_isDownloaded[index] == false ||
                            _needsUpdate[index]) &&
                        _generatedDownloadStatus)
                      TextButton(
                          onPressed: () {
                            downloadItem(index);
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(_needsUpdate[index]
                                  ? Icons.system_update_alt_outlined
                                  : Icons.download_rounded),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(_needsUpdate[index] ? context.tr("update") : context.tr("download")),
                            ],
                          )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.close_rounded),
                          Text(context.tr("close")),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_generatedDownloadStatus) {
      generateDownloadStatus();
    }
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.tr("download-page")),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: downloadItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              textColor: _isDownloaded[index]
                  ? _needsUpdate[index]
                      ? Colors.amber
                      : Colors.green
                  : Theme.of(context).listTileTheme.textColor,
              title: Text(downloadItems[index].name),
              subtitle: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    downloadItems[index].flag,
                    shape: const RoundedRectangle(3),
                    width: 18,
                    height: 12,
                  ),
                  Text(' ${downloadItems[index].language}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.info_outline_rounded),
                onPressed: () {
                  showInfoDialog(index);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
