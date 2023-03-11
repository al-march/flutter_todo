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
      listKey.currentState!.insertItem(
        0,
        duration: const Duration(milliseconds: 240),
      );
    }

    removeTodo(Todo todo) {
      var todoIndex = -1;
      for (var i = 0; i < state.todos.length; i++) {
        var t = state.todos[i];
        if (todo.id == t.id) {
          todoIndex = i;
          break;
        }
      }

      if (todoIndex < 0) {
        return;
      }

      listKey.currentState!.removeItem(
        todoIndex,
        (context, animation) => TodoItem(
          todo: todo,
          animation: animation,
          onRemove: (Todo _) {},
          onToggle: (Todo _) {},
        ),
        duration: const Duration(milliseconds: 120),
      );

      state.deleteTodo(todo.id);
    }

    toggleTodo(Todo todo) {
      state.toggleTodo(todo);
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
                              onToggle: toggleTodo,
                              onRemove: removeTodo,
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

  final void Function(Todo todo) onRemove;
  final void Function(Todo todo) onToggle;

  const TodoItem({
    super.key,
    required this.todo,
    required this.animation,
    required this.onRemove,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        height: 60.0,
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
                Checkbox(
                  value: todo.isDone,
                  onChanged: (bool? _) {
                    onToggle(todo);
                  },
                ),
                Text(todo.name),
                const Spacer(flex: 1),
                IconButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    onRemove(todo);
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
