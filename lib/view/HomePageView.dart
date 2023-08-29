import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/HomePageViewViewModel.dart';
import 'CalendarPageView.dart';
import 'ProfilePageView.dart';
import 'TodayPageView.dart';
import 'TodoPageView.dart'; //뷰모델을 가져와야 합니다.

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageViewViewModel(), // 뷰모델을 생성하여 제공합니다.
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<HomePageViewViewModel>(context); // 뷰모델을 가져옵니다.

    return Scaffold(
      body: [
        const TodayPageView(),
        const CalendarPageView(),
        const TodoPageView(),
        const ProfilePageView(),
      ][viewModel.currentIndex], // 현재 선택된 인덱스의 페이지를 보여줍니다.
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Colors.grey[200],
        currentIndex: viewModel.currentIndex,
        onTap: (index) {
          viewModel.changePage(index); // 페이지 변경을 뷰모델에 요청합니다.
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today,
            ),
            label: "Today",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
            ),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check,
            ),
            label: "To-Do",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
