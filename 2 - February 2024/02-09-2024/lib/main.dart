// Importing required packages
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    home: TodoList(),
  ));
}

class TodoList extends StatefulWidget {
  TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Future<Database> database;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialiseDatabase();
  }

  void initialiseDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'todo_list.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, isDone INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    final Database db = await database;

    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> tasks() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isDone: maps[i]['isDone'] == 1,
      );
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await database;

    await db.update(
      'tasks',
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;

    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: FutureBuilder<List<Task>>(
        future: tasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Task>? tasks = snapshot.data;

            if (tasks == null || tasks.isEmpty) {
              return const Center(child: Text('No tasks'));
            } else {
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index].title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: tasks[index].isDone,
                          onChanged: (value) {
                            setState(() {
                              tasks[index].isDone = value ?? false;
                            });

                            updateTask(tasks[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteTask(tasks[index].id);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add a task'),
                content: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(hintText: "Enter task here"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('ADD'),
                    onPressed: () {
                      final String textVal = _textController.text;
                      if (textVal.isNotEmpty) {
                        insertTask(Task(id: DateTime.now().millisecondsSinceEpoch, title: textVal));
                        _textController.clear();
                        setState(() {});
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class Task {
  final int id;
  final String title;
  bool isDone;

  Task({required this.id, required this.title, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone ? 1 : 0,
    };
  }
}