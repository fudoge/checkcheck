import 'package:flutter/material.dart';

import 'RoutineView.dart';
import 'ToDayToDoView.dart';

class TodayPageView extends StatefulWidget {
  const TodayPageView({super.key});

  @override
  State<TodayPageView> createState() => _TodayPageViewState();
}

class _TodayPageViewState extends State<TodayPageView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Tue Aug 29"),
        backgroundColor: Colors.blue[200],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          TabBar(
            padding: EdgeInsets.symmetric(horizontal: 10),
            controller: _controller,
            tabs: [
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text("Today To-Do"),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text("Routine"),
              ),
            ],
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 251, 240, 178)),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [TodayToDoView(), RoutineView()],
            ),
          )
        ],
      ),
    );
  }
}
