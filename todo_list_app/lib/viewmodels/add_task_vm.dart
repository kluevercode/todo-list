import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_app/viewmodels/task_list_vm.dart';
import '../models/task.dart';
import '../services/api_service.dart';

final addTaskViewModelProvider =
    ChangeNotifierProvider<AddTaskViewModel>((ref) {
  return AddTaskViewModel(apiService: ref.read(apiServiceProvider), ref: ref);
});

class AddTaskViewModel extends ChangeNotifier {
  final ApiService apiService;
  final Ref ref;

  AddTaskViewModel({required this.apiService, required this.ref});

  Future<void> addTask(Task task) async {
    try {
      await apiService.addTask(task);
      final taskListVM = ref.read(taskListViewModelProvider);
      await taskListVM.fetchTasks();
      notifyListeners();
    } catch (error) {
      print('Error occurred while adding task: $error');
      throw Exception('Failed to add task');
    }
  }
}
