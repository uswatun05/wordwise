import 'package:flutter/material.dart';
import '../api/wod.dart';

class WordOfDayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: WordOfDayService.fetchWordOfDay(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Failed to load word of teh day');
        } else if (snapshot.hasData) {
          final word = snapshot.data!['word']!;
          final definition = snapshot.data!['definition']!;
          return Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              
            ),
            child: Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('📅 Word of the Day', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),

                Text(word, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink, fontFamily: 'Pacifico',
                ),
                textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),

                Text(definition, style: TextStyle(fontSize: 15, fontFamily: 'RobotoSlab',
                ),
                textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox.shrink(); 
        }
      },
    );
  }
}
