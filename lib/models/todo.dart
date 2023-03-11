class Todo {
  final String id;
  String name;
  bool isDone;

  Todo({
    required this.name,
    required this.id,
    this.isDone = false,
  });

  void complete() {
    isDone = true;
  }

  void updateName(String newName) {
    name = newName;
  }
}
