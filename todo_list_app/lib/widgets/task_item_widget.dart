import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final Function(int) toggleStatus;
  final Function(int) deleteTask;
  final Function onTap;

  TaskItemWidget(
      {required this.task,
      required this.toggleStatus,
      required this.deleteTask,
      required this.onTap});

  Future<bool> _showDeleteConsentDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Delete'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you really want to delete this task?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // User clicked Cancel button
                  },
                ),
                TextButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // User clicked Delete button
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Color? priorityColor;
    IconData? priorityIcon;

    switch (task.priority) {
      case 1:
        priorityColor = Colors.red;
        priorityIcon = Icons.priority_high;
        break;
      case 2:
        priorityColor = Colors.green;
        priorityIcon = Icons.circle;
        break;
      case 3:
        priorityColor = Colors.grey;
        priorityIcon = Icons.circle;
        break;
    }

    return ListTile(
      title: Text(task.title),
      onTap: () => onTap(),
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
            onPressed: () async {
              bool shouldDelete = await _showDeleteConsentDialog(context);
              if (shouldDelete) {
                deleteTask(task.id);
              }
            },
          ),
        ],
      ),
    );
  }
}
