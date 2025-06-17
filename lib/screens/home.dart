import 'package:flutter/material.dart';
import 'translate.dart';
import 'word_of_day.dart';
import '../api/dictionary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
import 'settings.dart';
import 'word_of_day.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

  class _HomePageState extends State<HomePage> {
    final TextEditingController _controller = TextEditingController();
    final FocusNode _focusNode = FocusNode();
    List<Map<String, dynamic>> _definitions = [];
    List<String> _history = [];
    bool _isLoading = false;
    bool _showHistory = false;

    Future<void> _loadHistory() async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _history = prefs.getStringList('history') ?? [];
      });
    }
    Future<void> _saveHistory() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('history', _history);
      print('History saved: $_history');
    }
    

    @override
    void initState() {
      super.initState();
      _loadHistory();

    _controller.addListener(() {
      final input = _controller.text.trim().toLowerCase();
        setState(() {
          _showHistory = _focusNode.hasFocus && input.isNotEmpty;
        });
    });

    _focusNode.addListener(() {
      setState(() {
        _showHistory = _focusNode.hasFocus && _controller.text.trim().isNotEmpty;
      });
    });  
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
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
        if (!_history.map((e) => e.toLowerCase()).contains(_controller.text.trim().toLowerCase())) {
          _history.insert(0, _controller.text.trim());
          if (_history.length > 8) _history.removeLast();
          }
      });
      await _saveHistory();

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
        _focusNode.unfocus();
        _showHistory = false;
      });
    }
  }
  
  Widget buildDefinitionCards() {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var def in _definitions) {
      final pos = def['partOfSpeech']?.toLowerCase() ?? 'other';
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
                      '${partOfSpeech.isNotEmpty ? partOfSpeech[0].toUpperCase() + partOfSpeech.substring(1) : 'Unknown'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 25,
                        fontFamily: 'Pacifico',
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
                      fontFamily: 'RobotoSlab'
                     ),
                    ),
                    if (d['example'] != null && d['example'].toString().trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '💬 "${d['example']}"',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[700],fontFamily: 'RobotoSlab'),
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
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.3),
              builder: (context) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    child: Material(
                      color: Colors.white,
                      elevation: 16,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: SettingsPage(),
                      ),
                    ),
                  );
                },
              );
            },             
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
          Column(
            children: [
              TextField(
                focusNode: _focusNode,
                controller: _controller,
                onSubmitted: (_) => _searchWord(),
                decoration: InputDecoration(
                  hintText:'search for words....',
                  hintStyle: TextStyle(fontFamily:'RobotoSlab',fontSize:15,color: Colors.grey,),
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
            ),

              if (_showHistory && _history.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY:10),
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      constraints: BoxConstraints(maxHeight: 200),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: _history.map((word) {
                        return ListTile(
                          title: Text(word, style: TextStyle(fontFamily: 'RobotoSlab')),
                          trailing: IconButton(
                            icon: Icon(Icons.close, color: Colors.grey),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Hapus History'),
                                  content: Text('Kamu yakin ingin menghapus "$word" dari riwayat?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Batal'),
                                      onPressed: () => Navigator.of(context).pop(false),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                      child: Text('Hapus'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                setState(() {
                                  _history.remove(word);
                                });
                                await _saveHistory();
                              }
                            },
                          ),
                        
                          onTap: () {
                            _controller.text = word;
                            _searchWord();
                            _focusNode.unfocus();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_controller.text.isEmpty && !_isLoading)
          WordOfDayWidget(),
          
          SizedBox(height: 24),

                if (_isLoading)
                  Center(child: CircularProgressIndicator())
                else if (_definitions.isNotEmpty)
                  Column(
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
          Navigator.push(
            context, 
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
