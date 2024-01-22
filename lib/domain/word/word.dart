import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'word.g.dart';

@riverpod
List<Word> words(WordsRef ref) => [Word()];

class Word {
  final String name = '';
  final String url = '';
}
