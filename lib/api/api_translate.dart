import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslateService {
  static Future<String> translate(String text) async {
    final url = Uri.parse(
      'https://api.mymemory.translated.net/get?q=$text&langpair=en|id',
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['responseData']['translatedText'];
    } else {
      throw Exception('Gagal translate');
    }
  }
}
