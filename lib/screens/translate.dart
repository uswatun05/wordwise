import 'package:flutter/material.dart';
import '../api/api_translate.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  String translatedText = '';

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
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xFFD81B60),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Translate', style: TextStyle(color: Colors.white, fontFamily: 'Caprasimo', fontSize: 24,
        ),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(sourceLabel, style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'RobotoSlab', fontSize: 16,
                ),
              ),
                IconButton(
                  icon: Icon(Icons.swap_horiz, color: Theme.of(context).iconTheme.color),
                  onPressed: swapLanguages,
                ),
                Text(targetLabel, style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'RobotoSlab', fontSize: 16,
                  ),
                ),
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
                    Text(sourceLabel, style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'RobotoSlab', fontSize: 14,
                    ),
                  ),
                    TextField(
                      controller: _controller,
                      minLines: 3,
                      maxLines: null,
                      cursorColor: Colors.pink,
                      style: TextStyle(fontFamily: 'RobotoSlab'),
                      decoration: InputDecoration(
                        hintText: 'Enter text...',
                        hintStyle: TextStyle(fontFamily: 'RobotoSlab', color: Theme.of(context).hintColor),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce = Timer(const Duration(milliseconds: 100), () {
                          handleTranslate();
                        });
                      },
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
                      Text(targetLabel, style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'RobotoSlab', fontSize: 14,
                      ),
                    ),
                      const SizedBox(height: 10),
                      Expanded(
                              child: SingleChildScrollView(
                          child: Text(
                            translatedText.isNotEmpty
                              ? translatedText
                              : 'Translation will appear here....',
                            style: TextStyle(
                              fontFamily: 'RobotoSlab', 
                              fontSize: 14,
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}