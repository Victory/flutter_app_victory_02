import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome.',
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup the Name Generator')
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions  () {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, ii) {
        if (ii.isOdd) return Divider();

        final index = ii ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair suggestion) {
    return ListTile(
      title: Text(
        suggestion.asPascalCase,
        style: _biggerFont,
      )
    );
  }
}

class RandomWords extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}