import 'dart:convert';
import 'package:http/http.dart' as http;

class WordOfDayService {
  static Future<Map<String, String>> fetchWordOfDay() async {
    final response = await http.get(
      Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/random'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'word': data[0]['word'],
        'definition': data[0]['meanings'][0]['definitions'][0]['definition'],
      };
    } else {
      throw Exception('Failed to fetch word of the day');
    }
  }
}
