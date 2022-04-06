import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? _prefs;

  final String saveDataSlotSeparator = '//end//';
  final String saveDataTaskDueDateFormat = 'yyyy-MM-dd hh:mm:ss';

  final String _saveDataTaskTitleKey = 'taskTitle';
  final String _saveDataTaskDescriptionKey = 'taskDescription';
  final String _saveDataTaskDueDateKey = 'taskDueDate';
  final String _saveDataTaskTypeKey = 'taskType';
  final String _saveDataTaskStatusKey = 'taskStatus';

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Storage() {
    init();
  }

  void _putSaveDataString(String key, String value) {
    if (_prefs != null) _prefs!.setString(key, value);
  }

  void putSaveDataTaskTitle(String value) {
    _putSaveDataString(_saveDataTaskTitleKey, value);
  }

  void putSaveDataTaskDescription(String value) {
    _putSaveDataString(_saveDataTaskDescriptionKey, value);
  }

  void putSaveDataTaskDueDate(String value) {
    _putSaveDataString(_saveDataTaskDueDateKey, value);
  }

  void putSaveDataTaskType(String value) {
    _putSaveDataString(_saveDataTaskTypeKey, value);
  }

  void putSaveDataTaskStatus(String value) {
    _putSaveDataString(_saveDataTaskStatusKey, value);
  }

  String _getSaveDataString(String key) {
    return _prefs == null ? '' : _prefs!.getString(key) ?? '';
  }

  List<String> _getListSaveData(String key) {
    String saveDataString = _getSaveDataString(key);
    List<String> saveData = saveDataString.split(saveDataSlotSeparator);
    return saveData;
  }

  List<String> getListTaskTitle() {
    return _getListSaveData(_saveDataTaskTitleKey);
  }

  List<String> getListTaskDescription() {
    return _getListSaveData(_saveDataTaskDescriptionKey);
  }

  List<String> getListTaskDueDate() {
    return _getListSaveData(_saveDataTaskDueDateKey);
  }

  List<String> getListTaskType() {
    return _getListSaveData(_saveDataTaskTypeKey);
  }

  List<String> getListTaskStatus() {
    return _getListSaveData(_saveDataTaskStatusKey);
  }
}
