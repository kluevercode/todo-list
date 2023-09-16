import 'package:firebase_auth/firebase_auth.dart';

import '../models/task.dart';
import 'package:dio/dio.dart';

class ApiService {
  Future<List<Task>> fetchTasks() async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

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

  Future addTask(Task task) async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    final url = 'http://localhost:5137/Task';
    try {
      Response response = await dio.post(
        url,
        data: {
          'title': task.title,
          'description': task.description,
          'priority': task.priority,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        print('Failed to add task with status: ${response.statusCode}');
        throw Exception('Failed to add task');
      }
    } catch (error) {
      print('An error occurred while adding task: $error');
      throw Exception('Failed to add task due to an error: $error');
    }
  }

  Future<Task?> updateTask(Task task) async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    final url = 'http://localhost:5137/Task';
    try {
      Response response = await dio.put(
        url,
        data: {
          'id': task.id,
          'title': task.title,
          'description': task.description,
          'priority': task.priority,
          'isDone': task.isDone,
        },
      );

      if (response.statusCode != 200) {
        print('Failed to update task with status: ${response.statusCode}');
        throw Exception('Failed to update task');
      }
    } catch (error) {
      print('An error occurred while updating task: $error');
      throw Exception('Failed to update task due to an error: $error');
    }
  }

  Future deleteTask(int id) async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    final url = 'http://localhost:5137/Task';
    final Map<String, dynamic> queryParams = {
      'id': id,
    };

    try {
      Response response = await dio.delete(
        url,
        queryParameters: queryParams,
        data: {
          'id': id,
        },
      );

      if (response.statusCode != 200) {
        print('Failed to delete task with status: ${response.statusCode}');
        throw Exception('Failed to delete task');
      }
    } catch (error) {
      print('An error occurred while deleting task: $error');
      throw Exception('Failed to delete task due to an error: $error');
    }
  }
}
