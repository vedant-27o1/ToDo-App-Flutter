
class Task {
  String taskId;
  String taskName;
  bool isDone;

  Task({required this.taskId, required this.taskName, this.isDone = false});
  static List<Task> taskList() {
    return [
      Task(taskId: "01", taskName: "Jog", isDone: true),
      Task(taskId: "02", taskName: "Get groceries", isDone: true),
      Task(taskId: "03", taskName: "Code"),
      Task(taskId: "04", taskName: "Sleep"),
      Task(taskId: "05", taskName: "Dinner"),
    ];
  }
}
