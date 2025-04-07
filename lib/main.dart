import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Manager', home: TaskScreen());
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final taskController = TextEditingController();
  final dayController = TextEditingController();
  final timeController = TextEditingController();

  void addTask() {
    final taskName = taskController.text.trim();
    final day = dayController.text.trim();
    final time = timeController.text.trim();

    if (taskName.isNotEmpty && day.isNotEmpty && time.isNotEmpty) {
      FirebaseFirestore.instance.collection('tasks').add({
        'name': taskName,
        'day': day,
        'time': time,
        'completed': false,
      });
      taskController.clear();
      dayController.clear();
      timeController.clear();
    }
  }
}
