// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:codelab_first_flutter_app/main.dart';

void main() {
  testWidgets('FavoriteRandomWords shows favorites',
      (WidgetTester tester) async {
    // Setup
    var favoriteWords = generateWordPairs().take(5).toSet();
    await tester.pumpWidget(MaterialWrapper(
        testWidget: FavoriteRandomWords(favorites: favoriteWords)));

    // Assert
    favoriteWords.forEach((word) {
      expect(find.text(word.asPascalCase), findsOneWidget);
    });
  });
}

// A simple Material Widget to allow testing of smaller widgets within the MaterialApp context
class MaterialWrapper extends StatelessWidget {
  const MaterialWrapper({super.key, required this.testWidget});

  final Widget testWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Some Test Title"),
        ),
        body: testWidget,
      ),
    );
  }
}
