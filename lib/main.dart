import 'package:flutter/material.dart';
import 'package:todo_app/pages/start_page.dart';

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
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFEDEDED)
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();

  String todoName = '';
  bool isDisabled = false;

  List<String> todos = [];

  updateName(String name) {
    setState(() {
      todoName = name;
      isDisabled = name.isEmpty;
    });
  }

  onSubmit() {
    setState(() {
      todos.add(todoName);
      isDisabled = true;
      formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const StartPage();
  }
}
