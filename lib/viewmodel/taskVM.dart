import 'package:intl/intl.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/storage/storage.dart';

import 'dart:developer';

class TaskVM {
  final Storage _myStorage = Storage();

  void saveTask(String taskTitle, String taskDescription, DateTime taskDueDate,
      int taskType) {
    bool taskStatusDefault = false;
    Task newTask = Task(
        taskTitle, taskDescription, taskDueDate, taskType, taskStatusDefault);

    List<String> saveDataTaskTitleList = _myStorage.getListTaskTitle();
    List<String> saveDataTaskDescriptionList =
        _myStorage.getListTaskDescription();
    List<String> saveDataTaskDueDateList = _myStorage.getListTaskDueDate();
    List<String> saveDataTaskTypeList = _myStorage.getListTaskType();
    List<String> saveDataTaskStatusList = _myStorage.getListTaskStatus();

    saveDataTaskTitleList.add(newTask.taskTitle);
    saveDataTaskDescriptionList.add(newTask.taskDescription);
    saveDataTaskDueDateList.add(DateFormat(_myStorage.saveDataTaskDueDateFormat)
        .format(newTask.taskDueDate));
    saveDataTaskTypeList.add(newTask.taskType.toString());
    saveDataTaskStatusList.add(newTask.taskStatus ? '1' : '0');

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
