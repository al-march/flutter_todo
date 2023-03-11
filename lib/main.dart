import 'package:flutter/material.dart';
import 'package:todo_app/pages/start_page.dart';
import 'package:todo_app/pages/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.teal, 
        scaffoldBackgroundColor: const Color(0xFFEDEDED)
      ),
      home: const StartPage(),
    );
  }
}
