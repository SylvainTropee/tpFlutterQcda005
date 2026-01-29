class Task {
  String name;
  bool isCompleted;
  List<String> details;

  Task(this.name, this.isCompleted, this.details);

  Task.fromJson(Map<String, dynamic> json)
    : name = json['title'],
      isCompleted = json['completed'],
      details = [];

  @override
  String toString() {
    return 'Task{name: $name, isCompleted: $isCompleted, details: $details}';
  }
}
