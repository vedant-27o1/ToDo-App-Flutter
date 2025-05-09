import 'package:flutter/material.dart';
import 'package:todolist_app/core/constants/app_pallete.dart';
import 'package:todolist_app/features/home/domain/entities/task_entity.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final onTodoChange;
  final onTodoDelete;
  const TaskItem({
    super.key,
    required this.task,
    required this.onTodoChange,
    required this.onTodoDelete,
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dustbinWidthAnimation;
  late Animation<double> _checkboxWidthAnimation;

  bool _isExpandingDustbin = false;
  bool _isExpandingCheckbox = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getTimeRemaining(DateTime? deadline) {
    if (deadline == null) return "No deadline";

    final now = DateTime.now();
    final remaining = deadline.difference(now);

    if (remaining.isNegative) {
      return "Past due";
    } else if (remaining.inDays > 0) {
      return "${remaining.inDays} day(s) left";
    } else if (remaining.inHours > 0) {
      return "${remaining.inHours} hour(s) left";
    } else if (remaining.inMinutes > 0) {
      return "${remaining.inMinutes} minute(s) left";
    } else {
      return "Less than a minute left";
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    _dustbinWidthAnimation = Tween<double>(
      begin: 60.0,
      end: MediaQuery.of(context).size.width,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _checkboxWidthAnimation = Tween<double>(
      begin: 60.0,
      end: MediaQuery.of(context).size.width,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black),
        color: AppPalette.white,
      ),
      margin: EdgeInsets.all(16),
      height: 80,
      child: Stack(
        children: [
          if (!_isExpandingDustbin && !_isExpandingCheckbox)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    task.taskName,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      decoration:
                          task.isDone ? TextDecoration.lineThrough : null,
                      color: task.isDone ? Colors.grey : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

          Align(
            alignment: Alignment.centerLeft,
            child: Visibility(
              visible: !_isExpandingCheckbox,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text("Hold to delete.")),
                    );
                },
                onLongPress: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  _controller.forward();
                  setState(() {
                    _isExpandingDustbin = true;
                    _isExpandingCheckbox = false;
                  });
                },
                onLongPressEnd: (_) {
                  _controller.reverse();
                  setState(() {
                    _isExpandingDustbin = false;
                  });
                  widget.onTodoDelete(task.taskId);
                },
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Container(
                      width:
                          _isExpandingDustbin
                              ? _dustbinWidthAnimation.value
                              : 60.0,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppPalette.scaffoldBg,
                        borderRadius:
                            _isExpandingDustbin
                                ? BorderRadius.circular(40)
                                : BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Visibility(
              visible: !_isExpandingDustbin,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content:
                            !task.isDone
                                ? Text("Hold to mark as done.")
                                : Text("Hold to undo."),
                      ),
                    );
                },
                onLongPress: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  _controller.forward();
                  setState(() {
                    _isExpandingCheckbox = true;
                    _isExpandingDustbin = false;
                  });
                  widget.onTodoChange(task);
                },
                onLongPressEnd: (_) {
                  _controller.reverse();
                  setState(() {
                    _isExpandingCheckbox = false;
                  });
                },
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Container(
                      width:
                          _isExpandingCheckbox
                              ? _checkboxWidthAnimation.value
                              : 60.0,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppPalette.scaffoldBg,
                        borderRadius:
                            _isExpandingCheckbox
                                ? BorderRadius.circular(40)
                                : BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                      ),
                      child: Center(
                        child: Icon(
                          task.isDone
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 30,
                          color: task.isDone ? Colors.green : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
