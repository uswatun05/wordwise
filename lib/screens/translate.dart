import 'package:flutter/material.dart';
import '../api/api_translate.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final _ctrl = TextEditingController();
  bool _loading = false;
  String _output = '';

  void _doTranslate() async {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _loading = true;
      _output = '';
    });
    try {
      _output = await TranslateService.translate(_ctrl.text.trim());
    } catch (e) {
      _output = 'Error translate';
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: Text('Translate')),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Masukkan teks Inggris',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: _doTranslate),
          ),
          onSubmitted: (_) => _doTranslate(),
        ),
        SizedBox(height: 20),
        _loading
          ? CircularProgressIndicator()
          : _output.isNotEmpty
            ? Text(_output, style: TextStyle(fontSize: 18))
            : SizedBox(),
      ]),
    ),
  );
}