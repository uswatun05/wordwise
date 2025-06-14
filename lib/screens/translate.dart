import 'package:flutter/material.dart';
import '../api/api_translate.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final TextEditingController _controller = TextEditingController();

  String translatedText = '';
  bool isLoading = false;

  String sourceLang = 'en';
  String targetLang = 'id';
  String sourceLabel = 'English';
  String targetLabel = 'Indonesian';

  void swapLanguages() {
    setState(() {
      final tempLang = sourceLang;
      final tempLabel = sourceLabel;

      sourceLang = targetLang;
      targetLang = tempLang;

      sourceLabel = targetLabel;
      targetLabel = tempLabel;

      translatedText = '';
    });
  }

  Future<void> handleTranslate() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() => isLoading = true);
    try {
      final result = await TranslateService.translate(
        _controller.text.trim(),
        sourceLang,
        targetLang,
      );
      setState(() {
        translatedText = result;
      });
    } catch (e) {
      setState(() {
        translatedText = '⚠️ Translation failed.';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFFD81B60),
        centerTitle: true,
        title: Text('Translate', style: TextStyle(color: Colors.white, fontFamily: 'Caprasimo')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(sourceLabel, style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.swap_horiz, color: Colors.grey),
                  onPressed: swapLanguages,
                ),
                Text(targetLabel, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sourceLabel, style: TextStyle(fontWeight: FontWeight.bold)),
                    TextField(
                      controller: _controller,
                      minLines: 3,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter text...',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

           SizedBox(
            width: double.infinity,
            height: 150,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(targetLabel, style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    isLoading
                        ? CircularProgressIndicator()
                        : Text(translatedText.isNotEmpty ? translatedText : 'terjemahan'),
                  ],
                ),
              ),
            ),
          ),
            const SizedBox(height: 50),

            ElevatedButton.icon(
              onPressed: handleTranslate,
              icon: Icon(Icons.translate),
              label: Text("Translate"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD81B60),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
