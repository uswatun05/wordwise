import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/main_navigation.dart';

void main() {
  runApp(MyDictionaryApp());
}

class MyDictionaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordWise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SplashScreen(),
    );
  }
}
