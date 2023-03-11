import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    var todos = state.todos;

    addTodo(String name) {
      state.addTodo(name);
      listKey.currentState!.insertItem(0);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/todo-man.png'),
              ),
              const Text(
                "Todo  Tasks:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CreateTodoControl(
                        onSubmit: addTodo,
                      ),
                      AnimatedList(
                          key: listKey,
                          initialItemCount: todos.length,
                          shrinkWrap: true,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                            Animation<double> animation,
                          ) {
                            var todo = todos[index];
                            return TodoItem(
                              key: UniqueKey(),
                              todo: todo,
                              animation: animation,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateTodoControl extends StatelessWidget {
  CreateTodoControl({
    super.key,
    required this.onSubmit,
  });

  final void Function(String value) onSubmit;

  final input = TextEditingController();

  void submitForm() {
    var value = input.value.text;
    if (value.isEmpty) {
      return;
    }
    onSubmit(value);
    input.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: input,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter a TODo',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => {submitForm()},
          child: const Icon(Icons.add),
        )
      ],
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Animation<double> animation;

  const TodoItem({
    super.key,
    required this.todo,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        height: 40.0,
        child: Card(
          margin: const EdgeInsets.all(4),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: [
                Text(todo.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
