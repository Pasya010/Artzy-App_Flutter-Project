import 'package:arty_app/screens/home_screen.dart';
import 'package:arty_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class PagesNavigator extends StatefulWidget {
  const PagesNavigator({super.key});

  @override
  State<PagesNavigator> createState() => _PagesNavigatorState();
}

class _PagesNavigatorState extends State<PagesNavigator> {
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'A R T Z Y',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          fixedColor: Colors.black,
          currentIndex: selectedIndex,
          onTap: navigateBottomBar,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded, size: 30), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded, size: 30), label: ''),
          ]),
      drawer: Drawer(),
    );
  }
}
