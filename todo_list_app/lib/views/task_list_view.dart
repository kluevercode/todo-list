import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/task_list_vm.dart';
import '../widgets/task_item_widget.dart';

class TaskListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(taskListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the Add Task Screen (once you implement it)
            },
          )
        ],
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.tasks.length,
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  task: viewModel.tasks[index],
                  toggleStatus: viewModel.toggleTaskStatus,
                  deleteTask: viewModel.deleteTask,
                );
              },
            ),
    );
  }
}
