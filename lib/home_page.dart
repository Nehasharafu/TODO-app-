import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'task_model.dart'; // Import your task model

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<TaskModel> tasksBox;

  @override
  void initState() {
    super.initState();
    tasksBox = Hive.box<TaskModel>('tasksBox'); // Reference to the Hive box
  }

  void _addTask(String name, String description) {
    final newTask = TaskModel(taskName: name, description: description);
    tasksBox.add(newTask); // Add the task to the Hive box
  }

  void _toggleCheckbox(int index) {
    final task = tasksBox.getAt(index)!;
    task.isCompleted = !task.isCompleted;
    tasksBox.putAt(index, task); // Update the task in the Hive box
    setState(() {});
  }

  void _showAddTaskDialog() {
    final _taskNameController = TextEditingController();
    final _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Add New Task',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _taskNameController,
                decoration: InputDecoration(
                  labelText: 'Enter Task name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Enter Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Back',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                String taskName = _taskNameController.text.trim();
                String taskDescription = _descriptionController.text.trim();
                if (taskName.isNotEmpty && taskDescription.isNotEmpty) {
                  _addTask(taskName, taskDescription);
                  Navigator.of(context).pop(); // Close the dialog after saving
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do Tasks'),
        backgroundColor: Colors.blue[900],
      ),
      body: ValueListenableBuilder(
        valueListenable: tasksBox.listenable(),
        builder: (context, Box<TaskModel> box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No tasks yet. Add some!'));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final task = box.getAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Container(
                        width: 10,
                        height: double.infinity,
                        color: Colors.blue[900],
                      ),
                      title: Text(
                        task?.taskName ?? 'Unknown Task', // Safe null handling
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        task?.description ?? '', // Handling null safely
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      trailing: Checkbox(
                        value: task?.isCompleted ?? false, // Handling null safely
                        onChanged: (bool? value) {
                          _toggleCheckbox(index);
                        },
                        activeColor: Colors.blue[900],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  @override
  void dispose() {
    Hive.close(); // Close Hive when the app is disposed
    super.dispose();
  }
}
