import 'package:flutter/material.dart';
import 'package:todolist_app/core/constants/app_pallete.dart';

class MySearchBar extends StatefulWidget {
  final TextEditingController fieldController;
  final onTextChanged;
  final addTodoItem;

  const MySearchBar({
    super.key,
    required this.fieldController,
    required this.onTextChanged,
    required this.addTodoItem,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppPalette.fgColor),
      borderRadius: BorderRadius.circular(40),
    );
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) => widget.onTextChanged(value),
            controller: widget.fieldController,
            cursorColor: AppPalette.fgColor,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search or Add a To-Do",
              focusedBorder: outlineBorder,
              border: outlineBorder,
              errorBorder: outlineBorder,
              enabledBorder: outlineBorder,
              disabledBorder: outlineBorder,
              focusedErrorBorder: outlineBorder,
            ),
          ),
        ),
        if (widget.fieldController.text.isNotEmpty)
          IconButton(
            onPressed: () {
              widget.addTodoItem(widget.fieldController.text);
            },
            icon: Icon(Icons.add),
          ),
      ],
    );
  }
}
