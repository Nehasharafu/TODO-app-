import 'package:flutter/material.dart';
import 'package:todo_app_demo/add_task.dart';
import 'add_task.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = []; // Use dynamic to store name, description, and checkbox state

  void _addTask(String name, String description) {
    setState(() {
      tasks.add({
        'name': name,
        'description': description,
        'isChecked': false, // Default unchecked state
      });
    });
  }

  void _toggleCheckbox(int index) {
    setState(() {
      tasks[index]['isChecked'] = !tasks[index]['isChecked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do Tasks'),
        backgroundColor: Colors.blue[900],
      ),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet. Add some!'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
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
                        tasks[index]['name'] ?? 'Task Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        tasks[index]['description'] ?? 'Description',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      trailing: Checkbox(
                        value: tasks[index]['isChecked'],
                        onChanged: (bool? value) {
                          _toggleCheckbox(index);
                        },
                        activeColor: Colors.blue[900],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );

          if (result != null) {
            _addTask(result['name'], result['description']);
          }
        },
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
