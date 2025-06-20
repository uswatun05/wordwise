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
            bottomNavigationBar: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 1),
                        ),
                    ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(),
                    child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.transparent,
                        elevation: 0,        
                        currentIndex: _selectedIndex,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        selectedItemColor: Color(0xFFD81B60),
                        unselectedItemColor: Colors.grey[500],
                        onTap: _onItemTapped,
                        items: [
                            BottomNavigationBarItem(
                                icon: Icon(Icons.home_rounded, size: 30),
                                label: 'Home',
                            ),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.translate_rounded, size: 30),
                                label: 'Translate',
                            ),
                                ],
                            ),
                        ),
                    ),
                );
            }
        }