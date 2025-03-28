import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:skill_up/providers/navigation_provider.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<NavigationProvider>();
    final activeIndex = navigationProvider.currentIndex;
    return Scaffold(
      body: navigationProvider.currentScreen,
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: const Color.fromARGB(255, 52, 76, 183),
        onButtonPressed: (index) {
          navigationProvider.updateIndex(index);
        },
        iconSize: 30,
        activeColor: Colors.white,
        inactiveColor: Colors.grey[400],
        selectedIndex: activeIndex,
        barItems: [
          BarItem(icon: Icons.home_outlined, title: 'Home'),
          BarItem(icon: Icons.work_outline, title: 'Jobs'),
          BarItem(icon: Icons.book_outlined, title: 'Learning'),
          BarItem(icon: Icons.person_outline, title: 'Profile'),
        ],
      ),
    );
  }
}
