import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../services/api_service.dart';
import 'package:flutter/foundation.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final taskListViewModelProvider =
    ChangeNotifierProvider<TaskListViewModel>((ref) {
  return TaskListViewModel(apiService: ref.read(apiServiceProvider));
});

class TaskListViewModel extends ChangeNotifier {
  final ApiService apiService;
  List<Task> tasks = [];
  bool isLoading = true;

  TaskListViewModel({required this.apiService}) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      tasks = await apiService.fetchTasks();
      // Sort the tasks by priority
      tasks.sort((a, b) => a.priority.compareTo(b.priority));
      isLoading = false;
      notifyListeners();
    } catch (error) {
      // Handle errors, for example by setting an error state
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleTaskStatus(int id) async {
    var task = tasks.firstWhere((t) => t.id == id);
    task.isDone = !task.isDone;
    await apiService.updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await apiService.deleteTask(id);
    tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
