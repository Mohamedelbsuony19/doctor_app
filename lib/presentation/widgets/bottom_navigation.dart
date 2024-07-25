import 'package:flutter/material.dart';

import '../view/home_screen.dart';
import '../view/profile_screen.dart';
import '../view/schedules_screen.dart';

ClipRRect bottomNavigationBarBody(
    {required currentIndex,
    required Function(int)? onTap,
    required BuildContext context}) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(24),
      topLeft: Radius.circular(24),
    ),
    child: BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      items: const [
        BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home),
            label: 'Home'),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.alarm),
          label: 'Schedules',
        ),
        BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.person),
            label: 'Profile'),
      ],
    ),
  );
}

List<Widget> screens = const [
  HomeScreen(),
  SchedulesScreen(),
  ProfileScreen(),
];
