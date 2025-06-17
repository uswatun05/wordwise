import 'package:flutter/material.dart';
import 'dart:ui';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white.withOpacity(0.3),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text('Dark Mode', style: TextStyle(fontFamily: 'Poppins',fontSize: 12),),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About', style: TextStyle(fontFamily: 'Poppins',fontSize: 12),),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

