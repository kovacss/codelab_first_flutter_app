import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Welcome to Flutter', home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider();
          }
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          final text = _suggestions[index];
          final isSelected = _saved.contains(text);
          return ListTile(
            title: Text(text.asCamelCase, style: _biggerFont),
            trailing: Icon(
                isSelected ? Icons.favorite : Icons.favorite_border_outlined,
                color: isSelected ? Colors.pink : null,
                size: 24.0,
                semanticLabel: isSelected ? "Remove from favorites" : "Add to Favorites"),
            onTap: () {
              setState(() {
                if (isSelected) {
                  _saved.remove(text);
                } else {
                  _saved.add(text);
                }
              });
            },
          );
        }),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: FavoriteRandomWords(favorites: _saved));
    }));
  }
}

class FavoriteRandomWords extends StatelessWidget {
  final Set<WordPair> favorites;
  const FavoriteRandomWords({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    final tiles = favorites.map(
      (pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
          ),
        );
      },
    );
    return ListView(
        children: tiles.isNotEmpty
            ? ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList()
            : <Widget>[]);
  }
}
