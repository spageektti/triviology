import 'package:flutter/material.dart';
import 'package:triviology/navigation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Triviology',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
      darkTheme: ThemeData.dark(),
      home: const NavigationWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
