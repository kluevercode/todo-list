import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_app/viewmodels/task_list_vm.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class EditTaskViewModel extends ChangeNotifier {
  final ApiService apiService;
  final Ref ref;

  EditTaskViewModel({required this.apiService, required this.ref});

  void toggleIsDone(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    try {
      await apiService.updateTask(task);
      final taskListVM = ref.read(taskListViewModelProvider);
      await taskListVM.fetchTasks();
      notifyListeners();
    } catch (error) {
      // Handle errors, for example by setting an error state
      throw Exception('Failed to update the task: $error');
    }
  }
}

// Don't forget to provide this ViewModel in the widget tree similar to the Add Task ViewModel.
