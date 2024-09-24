import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter Task name',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Enter Description',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the page without saving
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty) {
                      Navigator.pop(context, {
                        'name': _nameController.text,
                        'description': _descriptionController.text,
                      });
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.blue[900], fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
