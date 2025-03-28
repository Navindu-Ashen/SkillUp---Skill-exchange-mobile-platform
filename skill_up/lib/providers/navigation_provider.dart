import 'package:flutter/material.dart';
import 'package:skill_up/screens/home/home_page.dart';
import 'package:skill_up/screens/job_search/job_search_page.dart';
import 'package:skill_up/screens/learning/learning_page.dart';
import 'package:skill_up/screens/profile/profile_page.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  Widget currentScreen = const HomePage();

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    if (_currentIndex == 0) {
      currentScreen = const HomePage();
    } else if (_currentIndex == 1) {
      currentScreen = const SearchPage();
    } else if (_currentIndex == 2) {
      currentScreen = const LearningPage();
    } else {
      currentScreen = const ProfilePage();
    }
    notifyListeners();
  }
}
