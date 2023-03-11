import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/start_page.dart';

import 'models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Flutter Todo',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.teal,
          scaffoldBackgroundColor: const Color(0xFFEDEDED),
        ),
        home: const StartPage(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  List<Todo> todos = [];

  addTodo(String name) {
    var todo = createTodo(name);
    todos.insert(0, todo);
    notifyListeners();
    return todo;
  }

  deleteTodo(String id) {
    todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  toggleTodo(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  createTodo(String name) {
    var id = DateTime.now().toString();
    return Todo(
      name: name,
      id: id,
    );
  }
}
