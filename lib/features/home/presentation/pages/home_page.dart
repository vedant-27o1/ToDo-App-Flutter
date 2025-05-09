import 'package:flutter/material.dart';
import 'package:todolist_app/core/constants/app_pallete.dart';
import 'package:todolist_app/features/home/domain/entities/task_entity.dart';
import 'package:todolist_app/features/home/presentation/widgets/my_search_bar.dart';
import 'package:todolist_app/features/home/presentation/widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  final todosList = Task.taskList();
  List<Task> _foundTasks = [];

  @override
  void initState() {
    _foundTasks = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.scaffoldBg,
        title: Text(
          "To-Dos List App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
      ),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: MySearchBar(
              fieldController: searchController,
              onTextChanged: (value) => _runFilter(value),
              addTodoItem: _addTodoItem,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "All To-Dos",
            style: TextStyle(
              fontSize: 32,
              color: AppPalette.fgColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (Task task in _foundTasks)
                  TaskItem(
                    task: task,
                    onTodoChange: _handleTodoChange,
                    onTodoDelete: _handleTodoDelete,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTodoChange(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _handleTodoDelete(String id) {
    setState(() {
      todosList.removeWhere((item) => item.taskId == id);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Task> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results =
          todosList
              .where(
                (item) => item.taskName.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
              )
              .toList();
    }

    setState(() {
      _foundTasks = results;
    });
  }

  void _addTodoItem(String todo) {
    setState(() {
      todosList.add(
        Task(
          taskId: DateTime.now().millisecondsSinceEpoch.toString(),
          taskName: todo,
        ),
      );
    });
    _runFilter(todo);
  }
}
