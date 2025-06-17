import 'package:flutter/material.dart';
import 'home.dart';
import 'translate.dart';
import 'word_of_day.dart';
import 'settings.dart';

class MainNavigation extends StatefulWidget {
    @override
    _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
    int _selectedIndex = 0;

    final List<Widget> _pages = [
        HomePage(),
        TranslatePage(),
    ];

    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                selectedItemColor: Color(0xFFD81B60),
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.language),
                        label: 'Translate',
                    ),
                ],
            ),
        );
    }
}