import 'package:task_manager/constants.dart';

class Task {
  String taskTitle = '';
  String taskDescription = '';
  DateTime taskDueDate = DateTime.now();
  int taskType = 0;
  bool taskStatus = false;

  Task(String taskTitle, String taskDescription, DateTime taskDueDate,
      int taskType, bool taskStatus) {
    this.taskTitle = (taskTitle.length > Constants.taskTitleMaxLength)
        ? taskTitle.substring(0, Constants.taskTitleMaxLength)
        : taskTitle;
    this.taskDescription =
        (taskDescription.length > Constants.taskDescriptionMaxLength)
            ? taskDescription.substring(0, Constants.taskDescriptionMaxLength)
            : taskDescription;
    this.taskDueDate = taskDueDate;
    this.taskType = ([0, 1, 2, 3, 4].contains(taskType)) ? taskType : 0;
    this.taskStatus = taskStatus;
  }
}
