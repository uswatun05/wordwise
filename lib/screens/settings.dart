import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
  
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).cardColor.withOpacity(0.8),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    Icon(Icons.dark_mode, size: 20),
                    SizedBox(width:10),
                    Expanded(
                      child: Text(
                        'Dark Mode', style: TextStyle(fontFamily: 'Poppins',fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    trailing: Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                    return Transform.scale(
                      scale: 0.75,
                      child: Switch(
                      value: isDarkMode,
                      activeColor: Colors.pink,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    Icon(Icons.info, size:20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'About',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        backgroundColor: Theme.of(context).cardColor,
                        title: Text(
                          'About WordWise',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFFD81B60),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📱 WordWise v1.0.0',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '✨ A simple, elegant dictionary app for everyday use.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            Text(
                              '© 2025 Uus\nAll rights reserved.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('Close', style: TextStyle(color: Color(0xFFD81B60),fontFamily: 'Poppins')),
                            onPressed: () => Navigator.pop(context),
                        ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

