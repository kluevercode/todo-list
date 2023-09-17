import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_app/models/task.dart';
import 'package:todo_list_app/viewmodels/edit_task_vm.dart';
import 'package:todo_list_app/viewmodels/task_list_vm.dart';

final editTaskViewModelProvider =
    ChangeNotifierProvider<EditTaskViewModel>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return EditTaskViewModel(apiService: apiService, ref: ref);
});

class EditTaskView extends ConsumerWidget {
  final Task task; // The task you want to edit
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late int priority;
  late bool isDone;

  EditTaskView({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    title = task.title;
    description = task.description;
    priority = task.priority;
    isDone = task.isDone;

    final viewModel = ref.watch(editTaskViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
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
                initialValue: description,
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
              CheckboxListTile(
                title: Text('Is done?'),
                value: isDone,
                onChanged: (newValue) {
                  viewModel.toggleIsDone(task);
                },
              ),
              ElevatedButton(
                child: Text('Update Task'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final updatedTask = Task(
                        id: task.id,
                        title: title,
                        description: description,
                        priority: priority,
                        isDone: isDone);

                    try {
                      await viewModel.updateTask(updatedTask);
                      Navigator.pop(context); // Go back to the task list screen
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update task.')),
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
