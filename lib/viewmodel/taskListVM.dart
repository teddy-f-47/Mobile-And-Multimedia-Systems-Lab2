import 'package:intl/intl.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/storage/storage.dart';

import 'dart:developer';

class TaskListVM {
  final Storage _myStorage = Storage();

  List<Task> _getAllTask() {
    List<String> saveDataTaskTitleList = _myStorage.getListTaskTitle();
    List<String> saveDataTaskDescriptionList =
        _myStorage.getListTaskDescription();
    List<String> saveDataTaskDueDateList = _myStorage.getListTaskDueDate();
    List<String> saveDataTaskTypeList = _myStorage.getListTaskType();
    List<String> saveDataTaskStatusList = _myStorage.getListTaskStatus();

    List<Task> output = [];
    for (int taskIndex = 0;
        taskIndex < saveDataTaskTitleList.length;
        taskIndex++) {
      if (saveDataTaskTitleList[taskIndex] != '') {
        String indTaskTitle = saveDataTaskTitleList[taskIndex];
        String indTaskDescription = saveDataTaskDescriptionList[taskIndex];
        DateTime indTaskDueDate =
            DateFormat(_myStorage.saveDataTaskDueDateFormat)
                .parse(saveDataTaskDueDateList[taskIndex]);
        int indTaskType = int.parse(saveDataTaskTypeList[taskIndex]);
        bool indTaskStatus =
            (saveDataTaskStatusList[taskIndex] == '1') ? true : false;

        Task indTask = Task(indTaskTitle, indTaskDescription, indTaskDueDate,
            indTaskType, indTaskStatus);
        output.add(indTask);
      }
    }

    return output;
  }

  int countAllTask() {
    List<Task> allTask = _getAllTask();
    return allTask.length;
  }

  String getTaskTitle(int taskIndex) {
    List<Task> allTask = _getAllTask();
    return allTask[taskIndex].taskTitle;
  }

  List<String> getAllTaskTitle() {
    List<Task> allTask = _getAllTask();

    List<String> output = [];
    for (int taskIndex = 0; taskIndex < allTask.length; taskIndex++) {
      output.add(allTask[taskIndex].taskTitle);
    }

    return output;
  }

  String getTaskDescription(int taskIndex) {
    List<Task> allTask = _getAllTask();
    return allTask[taskIndex].taskDescription;
  }

  List<String> getAllTaskDescription() {
    List<Task> allTask = _getAllTask();

    List<String> output = [];
    for (int taskIndex = 0; taskIndex < allTask.length; taskIndex++) {
      output.add(allTask[taskIndex].taskDescription);
    }

    return output;
  }

  DateTime getTaskDueDate(int taskIndex) {
    List<Task> allTask = _getAllTask();
    return allTask[taskIndex].taskDueDate;
  }

  List<DateTime> getAllTaskDueDate() {
    List<Task> allTask = _getAllTask();

    List<DateTime> output = [];
    for (int taskIndex = 0; taskIndex < allTask.length; taskIndex++) {
      output.add(allTask[taskIndex].taskDueDate);
    }

    return output;
  }

  int getTaskType(int taskIndex) {
    List<Task> allTask = _getAllTask();
    return allTask[taskIndex].taskType;
  }

  List<int> getAllTaskType() {
    List<Task> allTask = _getAllTask();

    List<int> output = [];
    for (int taskIndex = 0; taskIndex < allTask.length; taskIndex++) {
      output.add(allTask[taskIndex].taskType);
    }

    return output;
  }

  bool getTaskStatus(int taskIndex) {
    List<Task> allTask = _getAllTask();
    return allTask[taskIndex].taskStatus;
  }

  List<bool> getAllTaskStatus() {
    List<Task> allTask = _getAllTask();

    List<bool> output = [];
    for (int taskIndex = 0; taskIndex < allTask.length; taskIndex++) {
      output.add(allTask[taskIndex].taskStatus);
    }

    return output;
  }

  void markTaskDone(int rawIndex) {
    int taskIndex = rawIndex + 1;
    if (taskIndex < countAllTask()) {
      List<String> saveDataTaskStatusList = _myStorage.getListTaskStatus();
      saveDataTaskStatusList[taskIndex] = '1';
      String saveDataTaskStatusString =
          saveDataTaskStatusList.join(_myStorage.saveDataSlotSeparator);
      _myStorage.putSaveDataTaskStatus(saveDataTaskStatusString);
    }
  }

  void deleteTask(int rawIndex) {
    int taskIndex = rawIndex + 1;
    if (taskIndex < countAllTask()) {
      List<String> saveDataTaskTitleList = _myStorage.getListTaskTitle();
      List<String> saveDataTaskDescriptionList =
          _myStorage.getListTaskDescription();
      List<String> saveDataTaskDueDateList = _myStorage.getListTaskDueDate();
      List<String> saveDataTaskTypeList = _myStorage.getListTaskType();
      List<String> saveDataTaskStatusList = _myStorage.getListTaskStatus();

      saveDataTaskTitleList.removeAt(taskIndex);
      saveDataTaskDescriptionList.removeAt(taskIndex);
      saveDataTaskDueDateList.removeAt(taskIndex);
      saveDataTaskTypeList.removeAt(taskIndex);
      saveDataTaskStatusList.removeAt(taskIndex);

      String saveDataTaskTitleString =
          saveDataTaskTitleList.join(_myStorage.saveDataSlotSeparator);
      String saveDataTaskDescriptionString =
          saveDataTaskDescriptionList.join(_myStorage.saveDataSlotSeparator);
      String saveDataTaskDueDateString =
          saveDataTaskDueDateList.join(_myStorage.saveDataSlotSeparator);
      String saveDataTaskTypeString =
          saveDataTaskTypeList.join(_myStorage.saveDataSlotSeparator);
      String saveDataTaskStatusString =
          saveDataTaskStatusList.join(_myStorage.saveDataSlotSeparator);

      _myStorage.putSaveDataTaskTitle(saveDataTaskTitleString);
      _myStorage.putSaveDataTaskDescription(saveDataTaskDescriptionString);
      _myStorage.putSaveDataTaskDueDate(saveDataTaskDueDateString);
      _myStorage.putSaveDataTaskType(saveDataTaskTypeString);
      _myStorage.putSaveDataTaskStatus(saveDataTaskStatusString);
    }
  }
}
