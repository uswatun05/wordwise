import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/main_navigation.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: MyDictionaryApp(),
    ),
  );
}

class MyDictionaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'WordWise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
