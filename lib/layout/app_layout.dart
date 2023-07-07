import 'package:flutter/material.dart';

class appLayout extends StatelessWidget {
  List<BottomNavigationBarItem> bottomitem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.request_page_outlined),
      label: 'Requests',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inventory),
      label: 'Invoices',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
