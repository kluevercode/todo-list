class Task {
  final int id;
  final String title;
  final String description;
  final int priority;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority,
        'isDone': isDone,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        priority: json['priority'],
        isDone: json['isDone'],
      );
}
