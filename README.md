# task_manager

This repository contains the work for Lab2.

The application is developed with ***Flutter***.

## Screenshots
![Alt text](/dev_screenshots/tm1.PNG?raw=true "Homepage")
![Alt text](/dev_screenshots/tm2.PNG?raw=true "Creating a New Task")
![Alt text](/dev_screenshots/tm3.PNG?raw=true "Viewing a Particular Task")
![Alt text](/dev_screenshots/tm4_swipeleft.png?raw=true "Swiping Left to Mark Task as Done")
![Alt text](/dev_screenshots/tm4_swiperight.png?raw=true "Swiping Right to Delete Task")

## The built Android app

The APK file built for Android is available at:

build\app\outputs\flutter-apk\app-release.apk

The Appbundle file for Android is available at:

build\app\outputs\bundle\release\app-release.aab

## The code

All of the code for developing the app is available in the directory lib/.

### main.dart
This is the 'root' of the application containing the code for the application's main page.

### constants.dart
This file contains string constants that are re-usable across the app.

### styling.dart
This file contains constants for custom styling, also re-usable across the app.

### storage/storage.dart
This is the code that handles saving and retrieving data to/from SharedPreferences.

### model/task.dart
This is the code that contains the Task class. In a nutshell, it is used as a template for making a new task in the viewmodel.

### viewmodel/taskVM.dart
When creating a new task, this is the code that retrieves input data from the front-end and saves them to the storage.

### viewmodel/taskListVM.dart
When displaying the task list, this is the code that loads data from the storage and sends them to the front-end. It is also used when displaying a more detailed information of a particular task.

### page/newtask.dart
This is the code for the New Task page.

### page/detailtask.dart
This is the code for the page showing a more detailed information of a task.

## Dependencies

Information about dependencies can be found in the file pubspec.yaml.

