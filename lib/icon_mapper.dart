/*
* icon_mapper.dart - a file that maps the String icon names to the corresponding icons.
* home_page.dart - page where you can start the quiz.
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

IconData getIconData(String iconName) {
  switch (iconName) {
    case 'Icons.question_answer':
      return Icons.question_answer;
    case 'Icons.book':
      return Icons.book;
    case 'Icons.movie':
      return Icons.movie;
    case 'Icons.headphones':
      return Icons.headphones;
    case 'Icons.theater_comedy':
      return Icons.theater_comedy;
    case 'Icons.tv':
      return Icons.tv;
    case 'Icons.videogame_asset':
      return Icons.videogame_asset;
    case 'Icons.extension':
      return Icons.extension;
    case 'Icons.science_rounded':
      return Icons.science_rounded;
    case 'Icons.computer':
      return Icons.computer;
    case 'Icons.calculate':
      return Icons.calculate;
    case 'Icons.menu_book':
      return Icons.menu_book;
    case 'Icons.sports':
      return Icons.sports;
    case 'Icons.map':
      return Icons.map;
    case 'Icons.history_edu':
      return Icons.history_edu;
    case 'Icons.how_to_vote':
      return Icons.how_to_vote;
    case 'Icons.brush':
      return Icons.brush;
    case 'Icons.star':
      return Icons.star;
    case 'Icons.pets':
      return Icons.pets;
    case 'Icons.directions_car':
      return Icons.directions_car;
    case 'Icons.my_library_books':
      return Icons.my_library_books;
    case 'Icons.devices_other':
      return Icons.devices_other;
    case 'Icons.face':
      return Icons.face;
    case 'Icons.animation':
      return Icons.animation;
    default:
      return Icons.help;
  }
}
