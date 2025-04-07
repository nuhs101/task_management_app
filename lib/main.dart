import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

  void toggleCompletion(String id, bool currentStatus) {
    FirebaseFirestore.instance.collection('tasks').doc(id).update({
      'completed': !currentStatus,
    });
  }

  void deleteTask(String id) {
    FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(labelText: 'Task Name'),
                ),
                TextField(
                  controller: dayController,
                  decoration: InputDecoration(labelText: 'Day (e.g. Monday)'),
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    labelText: 'Time (e.g. 9am - 10am)',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: addTask, child: Text('Add Task')),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                Map<String, List<QueryDocumentSnapshot>> groupedTasks = {};
                for (var doc in snapshot.data!.docs) {
                  String groupKey = '${doc['day']} - ${doc['time']}';
                  if (!groupedTasks.containsKey(groupKey)) {
                    groupedTasks[groupKey] = [];
                  }
                  groupedTasks[groupKey]!.add(doc);
                }

                return ListView(
                  children:
                      groupedTasks.entries.map((entry) {
                        return ExpansionTile(
                          title: Text(entry.key),
                          children:
                              entry.value.map((taskDoc) {
                                return ListTile(
                                  title: Text(taskDoc['name']),
                                  leading: Checkbox(
                                    value: taskDoc['completed'],
                                    onChanged:
                                        (_) => toggleCompletion(
                                          taskDoc.id,
                                          taskDoc['completed'],
                                        ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => deleteTask(taskDoc.id),
                                  ),
                                );
                              }).toList(),
                        );
                      }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
