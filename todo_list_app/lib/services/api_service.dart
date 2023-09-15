import '../models/task.dart';
import 'package:dio/dio.dart';

class ApiService {
  List<Task> _taskList = [];

  Future<List<Task>> fetchTasks() async {
    Dio dio = Dio();

    try {
      Response response = await dio.get('http://localhost:5137/Task');

      if (response.statusCode == 200) {
        List<dynamic> responseBody = response.data;
        return responseBody.map((task) => Task.fromJson(task)).toList();
      } else {
        print('fetch failed with status: ${response.statusCode}');
        throw Exception('Failed to load tasks');
      }
    } catch (error) {
      print('An error occurred: $error');
      throw Exception('Failed to load tasks due to an error: $error');
    }
  }

  Future<Task?> addTask(Task task) async {
    await Future.delayed(Duration(seconds: 1));
    _taskList.add(task);
    return task;
  }

  Future<Task?> updateTask(Task task) async {
    await Future.delayed(Duration(seconds: 1));
    var index = _taskList.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _taskList[index] = task;
      return task;
    }
    return null;
  }

  Future<bool> deleteTask(int id) async {
    await Future.delayed(Duration(seconds: 1));
    var initialLength = _taskList.length;
    _taskList.removeWhere((t) => t.id == id);
    return _taskList.length != initialLength;
  }
}
