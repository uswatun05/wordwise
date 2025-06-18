import 'package:flutter/material.dart';

final lighTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFD81B60),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFD81B60),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Caprasimo',
        ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(),
    ),
    cardColor: Colors.white,
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black87,
        contentTextStyle: TextStyle(color: Colors.white),
    ),
    textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black87,fontFamily: 'RobotoSlab',),
        bodyMedium: TextStyle(color: Colors.black,fontFamily: 'RobotoSlab',),
    ),
    
    useMaterial3: true,
);

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFFD81B60),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFD81B60),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Caprasimo',
        ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey[900],
    ),
    cardColor: Color(0xFF1E1E1E),
    textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white,fontFamily: 'RobotoSlab',),
        bodyMedium: TextStyle(color: Colors.white70,fontFamily: 'RobotoSlab',),
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        contentTextStyle: TextStyle(color: Colors.white),
    ),
    useMaterial3: true,
);