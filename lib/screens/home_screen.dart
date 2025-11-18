import 'package:flutter/material.dart';
import '../models/task.dart';
import './new_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];

  void _addNewTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void _startAddNewTask(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return NewTaskScreen(onAddTask: _addNewTask);
        },
      ),
    );
  }

  void _startUpdateTask(BuildContext ctx, int index) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return NewTaskScreen(taskToUpdate: _tasks[index], onUpdateTask: (Task task) {
            _updateTask(index, task);
          });
        },
      ),
    );
  }

  void _updateTask(int index, Task task) {
    setState(() {
      _tasks[index] = task;
    });
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to remove the task?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              setState(() {
                _tasks.removeAt(index);
              });
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_alt, size: 80, color: Colors.black54),
                  SizedBox(height: 16),
                  Text(
                    'No tasks here.',
                    style: TextStyle(fontSize: 24, color: Colors.black54),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    onTap: () => _startUpdateTask(context, index),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '${_tasks[index].deadline.day}/${_tasks[index].deadline.month}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _tasks[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87, // Darker text for light theme
                      ),
                    ),
                    subtitle: Text(
                      _tasks[index].description,
                      style: const TextStyle(color: Colors.black54), // Darker text for light theme
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
