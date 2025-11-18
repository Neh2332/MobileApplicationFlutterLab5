import 'package:flutter/material.dart';
import '../models/task.dart';

class NewTaskScreen extends StatefulWidget {
  final Function(Task)? onAddTask;
  final Function(Task)? onUpdateTask;
  final Task? taskToUpdate;

  const NewTaskScreen({super.key, this.onAddTask, this.onUpdateTask, this.taskToUpdate});

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _deadline;

  @override
  void initState() {
    super.initState();
    if (widget.taskToUpdate != null) {
      _titleController.text = widget.taskToUpdate!.title;
      _descriptionController.text = widget.taskToUpdate!.description;
      _deadline = widget.taskToUpdate!.deadline;
    }
  }

  void _submitData() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _deadline == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure all fields are filled.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
      return;
    }

    final task = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      deadline: _deadline!,
    );

    if (widget.taskToUpdate != null) {
      widget.onUpdateTask!(task);
    } else {
      widget.onAddTask!(task);
    }

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _deadline = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskToUpdate != null ? 'Update Task' : 'Add New Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                controller: _titleController,
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                controller: _descriptionController,
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _deadline == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${_deadline!.toLocal()}'.split(' ')[0],
                      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(widget.taskToUpdate != null ? 'Update Task' : 'Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
