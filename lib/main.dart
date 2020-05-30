import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterappvictory02/physical.dart';
import 'package:flutterappvictory02/qanda.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome.',
      home: RandomWords(),
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Startup the Name Generator'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: _pushSaved,
            ),
            IconButton(
              icon: Icon(Icons.motorcycle),
              onPressed: _pushPhysics,
            ),
            IconButton(
              icon: Icon(Icons.whatshot),
              onPressed: _pushQuestionAndAnswers,
            ),
          ]
    ),
      body: _buildSuggestions(),
    );
  }

  void _pushQuestionAndAnswers() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => QuestionAndAnswerWidget())
    );
  }

  void _pushPhysics() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PhysicalStatelessWidget())
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                  (WordPair pair) {
                return ListTile(
                  title: Text(pair.asPascalCase, style: _biggerFont),
                );
              }
          );
          final List<Widget> divided = ListTile
            .divideTiles(context: context, tiles: tiles)
            .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Liked Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }
      )
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
      },
    );
  }

  Widget _buildRow(WordPair suggestion) {
    final alreadySaved = _saved.contains(suggestion);

    return ListTile(
      title: Text(
        suggestion.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.blue : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(suggestion);
          } else {
            _saved.add(suggestion);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}