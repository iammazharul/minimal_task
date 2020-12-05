import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimal_task/elements/task_item.dart';
import 'package:minimal_task/helpers/database_helper.dart';
import 'package:minimal_task/models/item.dart';
import 'package:minimal_task/models/task.dart';
import 'package:minimal_task/utils/constants.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({Key key, this.task}) : super(key: key);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  String _taskTitle = '';
  String _taskDescription = '';
  int _taskId = 0;

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _itemFocus;

  _onTaskSubmit(String title) async {
    if (_taskId == 0 && title != '') {
      Task _newTask = Task(title: title);
      _taskId = await _dbHelper.insertTask(_newTask);
      print('task creating');
    } else {
      await _dbHelper.updateTaskTitle(_taskId, title);
      // setState(() {});
      print('task updating');
    }

    _descriptionFocus.requestFocus();
  }

  _onDescriptionSubmit(String description) async {
    if (description != '' && _taskId != 0) {
      // _taskDescription = description;

      await _dbHelper.updateTaskDescription(_taskId, description);
    } else {
      print('issue on description');
    }
    _itemFocus.requestFocus();
  }

  _onItemSubmit(String title) async {
    if (_taskId != 0 && title != '') {
      Item _newItem = Item(taskId: _taskId, title: title, isDone: 0);
      await _dbHelper.insertItem(_newItem);
      _itemFocus.requestFocus();
      setState(() {});
    } else {
      print('issue on  item');
    }
  }

  _onCheckPress(int id, int isDone) async {
    if (isDone == 0) {
      await _dbHelper.updateItemIsDone(id, 1);
    } else {
      await _dbHelper.updateItemIsDone(id, 0);
    }
    setState(() {});
  }

  @override
  void initState() {
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _itemFocus = FocusNode();
    if (widget.task != null) {
      _taskId = widget.task.id;
      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
    } else {
      _titleFocus.requestFocus();
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _itemFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_taskId);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Color(0xFFFAF9FA),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 6.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: SvgPicture.asset(KImages.backIcon),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _titleFocus,
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            onChanged: (value) => _taskTitle = value,
                            onSubmitted: (value) => _onTaskSubmit(value),
                            decoration: InputDecoration(
                              hintText: KStrings.enterTaskTitle,
                              border: InputBorder.none,
                              hintStyle: KStyles.leargeHeadingRegularLight,
                            ),
                            style: KStyles.largeHeadingDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextField(
                      focusNode: _descriptionFocus,
                      textInputAction: TextInputAction.done,
                      maxLines: 3,
                      controller: TextEditingController()
                        ..text = _taskDescription,
                      onChanged: (value) => _taskDescription = value,
                      onEditingComplete: () {
                        _onDescriptionSubmit(_taskDescription);
                      },
                      decoration: InputDecoration(
                        hintText: KStrings.enterTaskDescription,
                        border: InputBorder.none,
                        hintStyle: KStyles.bodyRegular,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                      ),
                      style: KStyles.bodyDark,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 12.0),
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Color(0xFFFFFFFF),
                            border: Border.all(
                              width: 1.5,
                              color: Color(0xFFFBBC05),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _itemFocus,
                            controller: TextEditingController()..text = '',
                            onSubmitted: (value) => _onItemSubmit(value),
                            decoration: InputDecoration(
                              hintText: KStrings.createNewTask,
                              border: InputBorder.none,
                              hintStyle: KStyles.bodyRegular,
                            ),
                            style: KStyles.bodyDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getItems(_taskId),
                      builder: (context, snapshopt) {
                        return ListView.builder(
                          itemCount: snapshopt.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _onCheckPress(
                                  snapshopt.data[index].id,
                                  snapshopt.data[index].isDone),
                              child: TaskItem(
                                text: snapshopt.data[index].title,
                                isDone: snapshopt.data[index].isDone == 0
                                    ? false
                                    : true,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {
                    _dbHelper.deleteTaske(_taskId);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xFFEA4335),
                    ),
                    child: SvgPicture.asset(KImages.deleteIcon),
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
