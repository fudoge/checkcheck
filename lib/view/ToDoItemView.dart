import 'package:flutter/material.dart';

class ToDoItemView extends StatefulWidget {
  const ToDoItemView({super.key});

  @override
  State<ToDoItemView> createState() => _ToDoItemViewState();
}

class _ToDoItemViewState extends State<ToDoItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        // check bool TODO: value and onChanged.
        // Checkbox(value: false, onChanged: ),

        // task name
        Text("Make tuoorial.")
      ]),
    );
  }
}
