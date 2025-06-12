import 'package:flutter/material.dart';
import 'translate.dart';
import 'word_of_day.dart';
import 'history.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kamus Bahasa Inggris'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TranslatePage()),
              );
            },
            child: Text('Terjemahan'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WordOfDayPage()),
              );
            },
            child: Text('Kata Hari Ini'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
            child: Text('Riwayat Pencarian'),
          ),
        ],
      ),
    );
  }
}
