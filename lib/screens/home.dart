import 'package:flutter/material.dart';
import 'translate.dart';
import 'word_of_day.dart';
import 'history.dart';
import '../api/dictionary.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

  class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _definitions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.trim().isEmpty) {
        setState(() {
          _definitions = [];
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

    Future<void> _searchWord() async {
    if (_controller.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠ Enter the word first')),
        );
        return;
      }

    setState(() {
      _isLoading = true;
      _definitions = [];
    });

    try {
      List<Map<String, dynamic>> result = 
          await DictionaryService.fetchDefinitions(_controller.text.trim());
      setState(() {
        _definitions = result;
      });
    } catch (e) {
      setState(() {
        _definitions = [
          {
            'partOfSpeech': 'N/A',
            'definition': 'Word not found.',
            'example': null
          }
        ];
      });
      
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  Widget buildDefinitionCards() {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var def in _definitions) {
      final pos = def['partOfSpeech'] ?.toLowerCase() ?? 'Other';
      if (!grouped.containsKey(pos)) {
        grouped[pos] = [];
      }
      grouped[pos]!.add(def);
    }

    final Map<String, String> emojiMap = {
    'noun': '📘',
    'verb': '🛠️',
    'adjective': '💎',
    'adverb': '⚡',
    'interjection': '🎉',
    'preposition': '🔗',
    'conjunction': '➕',
    'pronoun': '🙋',
    'other': '📚',
  };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.map((entry) {
        final partOfSpeech = entry.key;
        final defs = entry.value;
        final emoji = emojiMap[partOfSpeech] ?? '📚';

        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
             Center(
              child: Text(
                '$emoji ${partOfSpeech != null && partOfSpeech.isNotEmpty 
                  ? '${partOfSpeech[0].toUpperCase()}${partOfSpeech.substring(1)}' 
                  : 'Other'}',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  letterSpacing: 1.2,
                ),
              ),
            ),
              SizedBox(height: 10),
              ...defs.map((d) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ${d['definition']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                     ),
                    ),
                    if (d['example'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '💬 "${d['example']}"',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'WordWise',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'Caprasimo'),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFFD81B60),
      automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'search for words....',
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Color(0xFFD81B60)),
                  onPressed: _searchWord,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color(0xFFD81B60), width:2),
            ),
          ),
            onSubmitted: (_) => _searchWord(),
          ),

              SizedBox(height: 24),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _definitions.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Results for: "${_controller.text.trim()}"',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          buildDefinitionCards(),
                        ],
                      )
                    : SizedBox(),

            SizedBox(height: 40),
            Divider(thickness: 1.2),
            SizedBox(height: 10),
            Center(
              child: Text(
                "🔎 Other Menu", 
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins'
                
                ),
              ),
            ),
            SizedBox(height: 12),

            Column(
              children: [
                customMenuButton(context, 'Translate', Icons.translate, TranslatePage()),
                customMenuButton(context, 'Word Of The Day', Icons.calendar_today, WordOfDayPage()),
                customMenuButton(context, 'History Search', Icons.history, HistoryPage()),
               ],
            ),
          ],
        ),
      ),
    );
  }


  Widget customMenuButton(BuildContext context, String title, IconData icon, Widget page) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(title,style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.push(context, 
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => page,
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(opacity: anim, child: child);
        },
        transitionDuration: Duration(milliseconds :400),
        ),
      );
    },

        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFEC407A),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}       
