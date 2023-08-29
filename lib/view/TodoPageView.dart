import 'package:flutter/material.dart';

import 'ToDoItemView.dart';

class TodoPageView extends StatefulWidget {
  const TodoPageView({super.key});

  @override
  State<TodoPageView> createState() => _TodoPageViewState();
}

class _TodoPageViewState extends State<TodoPageView> {
  List<Widget> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "To Do",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 251, 240, 178)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ToDoItemView();
        },
        itemCount: list.length,
      ),
    );
  }
}
