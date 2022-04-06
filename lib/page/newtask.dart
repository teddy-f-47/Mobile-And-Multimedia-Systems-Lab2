import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/styling.dart';
import 'package:task_manager/viewmodel/taskVM.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTask> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for capturing inputs from textfields.
  final taskTitleInputController = TextEditingController();
  final taskDescriptionInputController = TextEditingController();

  // Variables.
  final DateTime _taskDueDateDTFirst = DateTime(1991, 1, 1);
  final DateTime _taskDueDateDTLast = DateTime(2100, 12, 31);
  final String _taskDueDateFormat = 'dd-MMMM-yyyy';
  String _taskDueDateString = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
  DateTime _taskDueDateDTSelected = DateTime.now();
  int _taskTypeInt = 0;
  bool _formSaved = false;

  @override
  void initState() {
    super.initState();
    TaskVM initializeVM = TaskVM();
  }

  @override
  void dispose() {
    // For cleaning up the controllers when the widget is disposed.
    super.dispose();
    taskTitleInputController.dispose();
    taskDescriptionInputController.dispose();
  }

  void _selectDueDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _taskDueDateDTSelected,
      firstDate: _taskDueDateDTFirst,
      lastDate: _taskDueDateDTLast,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (selected != null && selected != _taskDueDateDTSelected) {
      setState(() {
        _taskDueDateDTSelected = selected;
        _taskDueDateString =
            DateFormat(_taskDueDateFormat).format(_taskDueDateDTSelected);
      });
    }
  }

  String _setTaskTypeLabel(int label) {
    switch (label) {
      case 1:
        return Constants.taskTypeValue1;
        break;
      case 2:
        return Constants.taskTypeValue2;
        break;
      case 3:
        return Constants.taskTypeValue3;
        break;
      case 4:
        return Constants.taskTypeValue4;
        break;
      default:
        return Constants.taskTypeValue0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(Constants.appTitle),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: Styling.verticalGapSmall),
                const Align(
                    alignment: Alignment.center,
                    child: Text(Constants.pageHeaderNewTask,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(height: Styling.verticalGapMedium),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Constants.taskTitleInputLabel,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                    width: MediaQuery.of(context).size.width *
                        Styling.inputWidthRelative,
                    child: TextFormField(
                      key: const Key(Constants.taskTitleInputKey),
                      autofocus: true,
                      decoration: const InputDecoration(
                          labelText: Constants.taskTitleInputHint),
                      controller: taskTitleInputController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Constants.taskInputValidationIfEmptyMsg +
                              Constants.taskTitleInputLabel;
                        } else if (value.length >
                            Constants.taskTitleMaxLength) {
                          return Constants.taskTitleInputLabel +
                              Constants.taskInputValidationIfTooLongMsg +
                              Constants.taskTitleMaxLength.toString();
                        } else {
                          return null;
                        }
                      },
                    )),
                const SizedBox(height: Styling.verticalGapMedium),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Constants.taskDescriptionInputLabel,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                    width: MediaQuery.of(context).size.width *
                        Styling.inputWidthRelative,
                    child: TextFormField(
                      key: const Key(Constants.taskDescriptionInputKey),
                      decoration: const InputDecoration(
                          labelText: Constants.taskDescriptionInputHint),
                      controller: taskDescriptionInputController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Constants.taskInputValidationIfEmptyMsg +
                              Constants.taskDescriptionInputLabel;
                        } else if (value.length >
                            Constants.taskDescriptionMaxLength) {
                          return Constants.taskDescriptionInputLabel +
                              Constants.taskInputValidationIfTooLongMsg +
                              Constants.taskDescriptionMaxLength.toString();
                        } else {
                          return null;
                        }
                      },
                    )),
                const SizedBox(height: Styling.verticalGapMedium),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Constants.taskDueDateInputLabel,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      Styling.inputWidthRelative,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: Styling.buttonInputTaskDueDateSize),
                    ),
                    onPressed: () {
                      _selectDueDate(context);
                    },
                    child: Text(_taskDueDateString),
                  ),
                ),
                const SizedBox(height: Styling.verticalGapMedium),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Constants.taskTypeInputLabel,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      Styling.inputWidthRelative,
                  child: DropdownButtonFormField<int>(
                    key: const Key(Constants.taskTypeInputKey),
                    decoration: const InputDecoration(
                        labelText: Constants.taskTypeInputHint),
                    value: _taskTypeInt,
                    items: [1, 2, 3, 4, 0]
                        .map((item) => DropdownMenuItem(
                              child: Text(_setTaskTypeLabel(item)),
                              value: item,
                            ))
                        .toList(),
                    hint: const Text(Constants.taskTypeInputHint),
                    validator: (value) {
                      if (value == null) {
                        return Constants.taskInputValidationIfEmptyMsg +
                            Constants.taskTypeInputLabel;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _taskTypeInt = value;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: Styling.verticalGapMedium),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate() &&
                            _formSaved == false) {
                          // If the form is valid, display a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text(Constants.buttonSaveSnackBarLabel)),
                          );
                          // Saving data via viewmodel
                          String taskTitle = taskTitleInputController.text;
                          String taskDescription =
                              taskDescriptionInputController.text;
                          DateTime taskDueDate = _taskDueDateDTSelected;
                          int taskType = _taskTypeInt;
                          TaskVM vm = TaskVM();
                          vm.saveTask(taskTitle, taskDescription, taskDueDate,
                              taskType);
                          setState(() {
                            _formSaved = true;
                          });
                          // Redirect back to the homepage
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: const Text(Constants.buttonSaveLabel),
                    )),
                const SizedBox(height: Styling.verticalGapSmall),
              ],
            ),
          ),
        ));
  }
}
