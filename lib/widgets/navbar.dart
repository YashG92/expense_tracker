import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      indicatorColor: Colors.lightBlue,
      selectedIndex: selectedIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 60,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.explore,
            color: Colors.white,
          ),
          icon: Icon(Icons.explore),
          label: 'Transaction',
        ),
      ],
    );
  }
}
