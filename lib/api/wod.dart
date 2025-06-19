import 'dart:math';

class WordOfDayService {
  static final List<Map<String, String>> _words = [
    {
      'word': 'Gratitude',
      'definition': 'A thankful appreciation for what one receives.'
    },
    {
      'word': 'Serenity',
      'definition': 'The state of being calm and peaceful.'
    },
    {
      'word': 'Courage',
      'definition': 'The ability to do something that frightens you.'
    },
    {
      'word': 'Mindfulness',
      'definition': 'A mental state achieved by focusing awareness on the present moment.'
    },
    {
      'word': 'Compassion',
      'definition': 'Sympathetic pity and concern for the sufferings or misfortunes of others.'
    },
    {
      'word': 'Resilience',
      'definition': 'The capacity to recover quickly from difficulties; toughness.'
    },
    {
      'word': 'Patience',
      'definition': 'The capacity to accept or tolerate delay, trouble, or suffering without getting angry.'
    },
    {
      'word': 'Optimism',
      'definition': 'Hopefulness and confidence about the future or the success of something.'
    },
    {
      'word': 'Empathy',
      'definition': 'The ability to understand and share the feelings of another.'
    },
    {
      'word': 'Integrity',
      'definition': 'The quality of being honest and having strong moral principles.'
    },
  ];

  static Map<String, String> getWordOfDay() {
    final today = DateTime.now().day;
    final index = today % _words.length;
    return _words[index];
  }
}