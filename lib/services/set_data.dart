import 'package:minimal_task/helpers/database_helper.dart';
import 'package:minimal_task/models/item.dart';
import 'package:minimal_task/models/task.dart';
import 'package:minimal_task/utils/constants.dart';

class SetData {
  SetData._();

  static void assign() async {
    DatabaseHelper _dbHelper = DatabaseHelper();
    int _taskId = 0;
    _taskId = await _dbHelper.insertTask(Task(
        title: KStrings.dummyHeading, description: KStrings.dummyDescription));
    await _dbHelper.insertItem(
        Item(taskId: _taskId, title: KStrings.dummyTask1, isDone: 1));
    await _dbHelper.insertItem(
        Item(taskId: _taskId, title: KStrings.dummyTask2, isDone: 0));
    await _dbHelper.insertItem(
        Item(taskId: _taskId, title: KStrings.dummyTask3, isDone: 0));
  }
}
