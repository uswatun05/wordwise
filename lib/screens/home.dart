import 'package:flutter/material.dart';
import 'translate.dart';
import 'word_of_day.dart';
import 'history.dart';
import '../api/dictionary.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

  class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _definitions = [];
  bool _isLoading = false;

  Future<void> _searchWord() async {
    setState(() {
      _isLoading = true;
      _definitions = [];
    });

    try {
      List<String> result = await DictionaryService.fetchDefinitions(_controller.text.trim());
      setState(() {
        _definitions = result;
      });
    } catch (e) {
      setState(() {
        _definitions = ['Kata tidak ditemukan.'];
      });
    } finally {
      if (_controller.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Masukkan kata terlebih dahulu')),
        );
        return;
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordWise'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Cari kata (dalam bahasa Inggris)',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: _searchWord,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _definitions.map((def) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text("- $def"),
                  )).toList(),
                ),
          SizedBox(height: 24),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TranslatePage()),
              );
            },
            child: Text('Translate'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WordOfDayPage()),
              );
            },
            child: Text('Word Of Day'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
            child: Text('History Search'),
          ),
        ],
      ),
    );
  }
}
