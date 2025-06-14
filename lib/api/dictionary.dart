import 'dart:convert';
import 'package:http/http.dart' as http;

  class DictionaryService {
  static Future<List<Map<String, dynamic>>> fetchDefinitions(String word) async {
  final url = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
  final response = await http.get(url);

    if (response.statusCode != 200) throw Exception('Word not found');
    

    final data = jsonDecode(response.body);
    List<Map<String, dynamic>> definitions = [];

  for (var meaning in data[0]['meanings']) {
    final partOfSpeech = meaning['partOfSpeech'];
    for (var def in meaning['definitions']) {
      definitions.add({
        'partOfSpeech': partOfSpeech,
        'definition': def['definition'],
        'example': def['example']
      });
    }
  }
    return definitions;
  }
}