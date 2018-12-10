import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      itemBuilder: (context, i) {
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[i]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
          ),
        ),
        child: Row(children: <Widget>[
          Expanded(
            child: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          ),
          Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
          ),
        ]),
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        title: 'Liked',
        builder: (BuildContext context) {
          final List<Widget> items =
              _saved.map((WordPair pair) => _buildRow(pair)).toList();
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text('Liked List')),
            child: SafeArea(
              top: true,
              bottom: false,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                children: items,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Startup Name Generator'),
        trailing: TextButton(label: 'Liked', onPressed: _pushSaved),
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: _buildSuggestions(),
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  const TextButton({
    Key key,
    this.label = 'Button',
    @required this.onPressed,
  })  : assert(label != null),
        super(key: key);

  final String label;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Text(this.label),
      onPressed: this.onPressed,
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
