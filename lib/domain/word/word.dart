import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'word.g.dart';

@riverpod
List<Word> words(WordsRef ref) => [Word('orange', '/path/to/orange_image')];

class Word {
  final String name;
  final String url;

  Word(this.name, this.url);

  Word fromJson(Map<String, dynamic> json) {
    return Word(
      json['name'],
      json['url'],
    );
  }
}
