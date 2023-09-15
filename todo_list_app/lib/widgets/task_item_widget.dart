import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final Function(int) toggleStatus;
  final Function(int) deleteTask;

  TaskItemWidget(
      {required this.task,
      required this.toggleStatus,
      required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    Color? priorityColor;
    IconData? priorityIcon;

    switch (task.priority) {
      case 1:
        priorityColor = Colors.red;
        priorityIcon = Icons.priority_high; // Example icon for high priority
        break;
      case 2:
        priorityColor = Colors.green;
        priorityIcon = Icons.circle; // Example icon for medium priority
        break;
      case 3:
        priorityColor = Colors.grey;
        priorityIcon = Icons.circle; // Example icon for low priority
        break;
    }

    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      leading: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          toggleStatus(task.id);
        },
      ),
      trailing: Row(
        mainAxisSize:
            MainAxisSize.min, // To make Row take as little space as possible
        children: [
          // Display the priority icon with the designated color
          Icon(
            priorityIcon,
            color: priorityColor,
          ),
          SizedBox(
              width:
                  8.0), // Give some space between the icon and the delete button
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteTask(task.id);
            },
          ),
        ],
      ),
    );
  }
}
