import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/styling.dart';
import 'package:task_manager/viewmodel/taskListVM.dart';

class DetailTask extends StatelessWidget {
  const DetailTask({Key? key, required this.taskIndex}) : super(key: key);
  final int taskIndex;
  final String _taskDueDateFormat = 'dd-MMMM-yyyy';

  @override
  Widget build(BuildContext context) {
    // Get the last data from viewmodel.
    TaskListVM vm = TaskListVM();

    String currentTaskTitle = vm.getTaskTitle(taskIndex);
    String currentTaskDescription = vm.getTaskDescription(taskIndex);
    DateTime currentTaskDueDate = vm.getTaskDueDate(taskIndex);
    int currentTaskType = vm.getTaskType(taskIndex);
    bool currentTaskStatus = vm.getTaskStatus(taskIndex);

    String currentTaskDueDateString =
        DateFormat(_taskDueDateFormat).format(currentTaskDueDate);
    String currentTaskTypeString = Constants.taskTypeValue0;
    Icon currentTaskTypeIcon = Icon(
      Icons.pending,
      size: Styling.iconSizeSmall,
    );
    String currentTaskStatusString = Constants.taskStatus0;
    switch (currentTaskType) {
      case 1:
        currentTaskTypeString = Constants.taskTypeValue1;
        currentTaskTypeIcon = Icon(
          Icons.event,
          size: Styling.iconSizeSmall,
        );
        break;
      case 2:
        currentTaskTypeString = Constants.taskTypeValue2;
        currentTaskTypeIcon = Icon(
          Icons.email,
          size: Styling.iconSizeSmall,
        );
        break;
      case 3:
        currentTaskTypeString = Constants.taskTypeValue3;
        currentTaskTypeIcon = Icon(
          Icons.call,
          size: Styling.iconSizeSmall,
        );
        break;
      case 4:
        currentTaskTypeString = Constants.taskTypeValue4;
        currentTaskTypeIcon = Icon(
          Icons.groups,
          size: Styling.iconSizeSmall,
        );
        break;
    }
    if (currentTaskStatus) {
      currentTaskStatusString = Constants.taskStatus1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appTitle),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: Styling.verticalGapSmall),
          Text(currentTaskTitle, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: Styling.verticalGapSmall),
          currentTaskTypeIcon,
          Text(currentTaskTypeString,
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: Styling.verticalGapSmall),
          Text(
            currentTaskDescription,
          ),
          const SizedBox(height: Styling.verticalGapSmall),
          Text(
            Constants.taskDueDateInputLabel,
          ),
          Text(
            currentTaskDueDateString,
          ),
          const SizedBox(height: Styling.verticalGapSmall),
          Text(
            Constants.taskStatusLabel,
          ),
          Text(
            currentTaskStatusString,
          ),
          const SizedBox(height: Styling.verticalGapMedium),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(Constants.btnLabelReturn),
          ),
        ],
      )),
    );
  }
}
