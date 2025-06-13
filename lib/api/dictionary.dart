import 'dart:convert';
import 'package:http/http.dart' as http;

class DictionaryService {
    static Future<List<String>> fetchDefinitions(String word) async {
        final url = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

        final response = await http.get(url);

        if (response.statusCode == 200) {
            final data = jsonDecode(response.body);

            List<String> definitions = [];
            for (var meaning in data[0]['meanings']) {
                for (var def in meaning['definitions']) {
                definitions.add(def['definition']);
                }
            }
            return definitions;
        } else {
        throw Exception('Kata tidak ditemukan atau API error');
        }
    }
    }