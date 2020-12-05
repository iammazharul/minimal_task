import 'package:minimal_task/models/item.dart';
import 'package:minimal_task/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'task.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
        );
        await db.execute(
            "CREATE TABLE items(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)");
        return db;
      },
      version: 1,
    );
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    final Database _db = await database();
    await _db
        .insert('tasks', task.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> updateTaskTitle(int id, String title) async {
    final Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateTaskDescription(int id, String description) async {
    final Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tasks SET description = '$description' WHERE id = '$id'");
  }

  Future<void> insertItem(Item item) async {
    final Database _db = await database();

    await _db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateItemIsDone(int id, int isDone) async {
    final Database _db = await database();
    await _db.rawUpdate("UPDATE items SET isDone = '$isDone' WHERE id = '$id'");
  }

  Future<void> deleteTaske(int id) async {
    final Database _db = await database();
    await _db.rawUpdate("DELETE FROM tasks WHERE id = '$id'");
    await _db.rawUpdate("DELETE FROM items WHERE taskId = '$id'");
  }

  Future<List<Task>> getTasks() async {
    final Database _db = await database();
    final List<Map<String, dynamic>> maps = await _db.query('tasks');

    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
      );
    });
  }

  Future<List<Item>> getItems(int taskId) async {
    final Database _db = await database();
    final List<Map<String, dynamic>> maps = await _db.rawQuery(
        "SELECT * FROM items WHERE taskId = '$taskId' ORDER BY id DESC");
    return List.generate(maps.length, (index) {
      return Item(
        id: maps[index]['id'],
        taskId: maps[index]['taskId'],
        title: maps[index]['title'],
        isDone: maps[index]['isDone'],
      );
    });
  }
}
