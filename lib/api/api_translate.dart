import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslateService {
  static Future<String> translate(String text, String source, String target) async {
    final res = await http.get(
      Uri.parse('https://api.mymemory.translated.net/get?q=$text&langpair=$source|$target'),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['responseData']['translatedText'];
    } else {
      throw Exception('Gagal translate');
    }
  }
}
