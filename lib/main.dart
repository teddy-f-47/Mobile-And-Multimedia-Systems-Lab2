import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/styling.dart';
import 'package:task_manager/page/newtask.dart';
import 'package:task_manager/page/detailtask.dart';
import 'package:task_manager/viewmodel/taskListVM.dart';

void main() {
  runApp(const MyTaskManagerApp());
}

class MyTaskManagerApp extends StatelessWidget {
  const MyTaskManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyTaskManagerAppHome(title: Constants.appTitle),
    );
  }
}

class MyTaskManagerAppHome extends StatefulWidget {
  const MyTaskManagerAppHome({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyTaskManagerAppHome> createState() => _MyTaskManagerAppState();
}

class _MyTaskManagerAppState extends State<MyTaskManagerAppHome> {
  int _numOfTasks = 0;

  final String _taskDueDateFormat = 'dd-MMMM-yyyy';

  void _updateTaskList() async {
    bool flagStorageReady = await _initializeStorage();
    TaskListVM vm = TaskListVM();
    setState(() {
      _numOfTasks = vm.countAllTask();
    });
  }

  Future<bool> _initializeStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return true;
  }

  void _initializeVM() {
    TaskListVM initializeVM = TaskListVM();
  }

  @override
  void initState() {
    super.initState();
    _initializeVM();
    _updateTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: Styling.paddingSmall),
              child: GestureDetector(
                onTap: () async {
                  final value = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewTask()));
                  _updateTaskList();
                },
                child: const Icon(
                  Icons.add,
                  size: Styling.iconSizeNormal,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.separated(
              // Build a list child as many as X times, where X = _numOfTasks.
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _numOfTasks,
              itemBuilder: (BuildContext context, int index) {
                TaskListVM vm = TaskListVM();

                String currentTaskTitle = vm.getTaskTitle(index);
                String currentTaskDescription = vm.getTaskDescription(index);
                DateTime currentTaskDueDate = vm.getTaskDueDate(index);
                int currentTaskType = vm.getTaskType(index);
                bool currentTaskStatus = vm.getTaskStatus(index);

                String currentTaskDueDateString =
                    DateFormat(_taskDueDateFormat).format(currentTaskDueDate);
                String currentTaskTypeString = Constants.taskTypeValue0;
                Icon currentTaskTypeIcon = Styling.iconTaskType0;
                String currentTaskStatusString = Constants.taskStatus0;
                switch (currentTaskType) {
                  case 1:
                    currentTaskTypeString = Constants.taskTypeValue1;
                    currentTaskTypeIcon = Styling.iconTaskType1;
                    break;
                  case 2:
                    currentTaskTypeString = Constants.taskTypeValue2;
                    currentTaskTypeIcon = Styling.iconTaskType2;
                    break;
                  case 3:
                    currentTaskTypeString = Constants.taskTypeValue3;
                    currentTaskTypeIcon = Styling.iconTaskType3;
                    break;
                  case 4:
                    currentTaskTypeString = Constants.taskTypeValue4;
                    currentTaskTypeIcon = Styling.iconTaskType4;
                    break;
                }
                if (currentTaskStatus) {
                  currentTaskStatusString = Constants.taskStatus1;
                }

                return GestureDetector(
                  onTap: () async {
                    final value = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailTask(taskIndex: index)));
                    _updateTaskList();
                  },
                  child: Dismissible(
                    key: Key(index.toString() + currentTaskTitle),
                    background: Container(color: Colors.red), //right, delete
                    secondaryBackground:
                        Container(color: Colors.green), //left, mark as done
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        //swipe right, to delete
                        final bool? res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(Constants.alertTaskDelete),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      Constants.btnLabelCancel,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      Constants.btnLabelDelete,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      TaskListVM vm = TaskListVM();
                                      vm.deleteTask(index);
                                      _updateTaskList();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      } else {
                        //swipe right, to mark as done
                        TaskListVM vm = TaskListVM();
                        vm.markTaskDone(index);
                        _updateTaskList();
                      }
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: Styling.verticalGapLarge,
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.all(Styling.verticalGapSmall),
                                child: currentTaskTypeIcon,
                              ),
                              Text(currentTaskTitle,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                Constants.taskDueDateInputLabel,
                              ),
                              Text(
                                currentTaskDueDateString,
                              ),
                              Text(
                                Constants.taskStatusLabel,
                              ),
                              Text(
                                currentTaskStatusString,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
            const SizedBox(height: Styling.verticalGapMedium),
          ],
        ),
      ),
    );
  }
}
