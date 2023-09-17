import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../viewmodels/add_task_vm.dart';

class AddTaskView extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  int priority = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(addTaskViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  description = value!;
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Priority'),
                value: priority,
                items: [
                  DropdownMenuItem(value: 1, child: Text('High')),
                  DropdownMenuItem(value: 2, child: Text('Medium')),
                  DropdownMenuItem(value: 3, child: Text('Low')),
                ],
                onChanged: (value) {
                  priority = value!;
                },
              ),
              ElevatedButton(
                child: Text('Add Task'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newTask = Task(
                      id: 0,
                      title: title,
                      description: description,
                      priority: priority,
                    );

                    try {
                      await viewModel.addTask(newTask);
                      Navigator.pop(context); // Go back to the task list screen
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add task.')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
