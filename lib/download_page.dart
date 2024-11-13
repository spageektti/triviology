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
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:country_flags/country_flags.dart';

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
  final String version;
  final String copyright;

  DownloadItem(
      {required this.name,
      required this.description,
      required this.githubOrg,
      required this.githubRepo,
      required this.language,
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
      name: 'Open Trivia Database API',
      description:
          'The Open Trivia Database API provides questions for 24 categories, with 3 difficulty levels, and 2 question types (multiple choice and true/false). It requires internet access tho.',
      githubOrg: 'triviology',
      githubRepo: 'opentdbapi',
      version: 'v1.0.0',
      language: 'en',
      copyright: 'CC BY-SA 4.0 opentdb.com'),
  DownloadItem(
      name: 'Open Trivia Database',
      description:
          'The Open Trivia Database provides questions for 24 categories, with 3 difficulty levels, and 2 question types (multiple choice and true/false). Questions are saved locally.',
      githubOrg: 'triviology',
      githubRepo: 'opentdb',
      version: 'v1.0.0',
      language: 'en',
      copyright: 'CC BY-SA 4.0 opentdb.com'),
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
        setState(() {
          _isDownloaded[i] = true;
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
    final response = await HttpClient().getUrl(Uri.parse(url));
    final download = await response.close();
    if (download.statusCode == 404 ||
        (await download.transform(utf8.decoder).join()) ==
            '{"error":"Not Found"}') {
      //display error dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Download Failed'),
            content: const Text(
                'Unable to download the file. Please check your internet connection and try again.'),
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
      return;
    }
    downloadJson
        .writeAsBytes(await download.expand((element) => element).toList());
    setState(() {
      _isDownloaded[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_generatedDownloadStatus) {
      generateDownloadStatus();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Page'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: downloadItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              textColor: _isDownloaded[index]
                  ? Colors.green
                  : Theme.of(context).listTileTheme.textColor,
              title: Text(downloadItems[index].name),
              subtitle: Row(
                children: [
                  CountryFlag.fromLanguageCode(
                    downloadItems[index].language,
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
                            Text('Version: ${downloadItems[index].version}'),
                            Row(
                              children: [
                                const Text('Language: '),
                                CountryFlag.fromLanguageCode(
                                  downloadItems[index].language,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (_isDownloaded[index] == false &&
                                  _generatedDownloadStatus)
                                TextButton(
                                    onPressed: () {
                                      downloadItem(index);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.download_rounded),
                                        Text('Download'),
                                      ],
                                    )),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.close_rounded),
                                    Text('Close'),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
