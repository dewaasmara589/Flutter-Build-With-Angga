
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'genre_provider.g.dart';

// Cara 1 provider biasa bukan state
// @riverpod
// String genre(GenreRef ref) => 'Shooter';

// Cara 2
@riverpod
class GenreNotifier extends _$GenreNotifier {
  @override
  String build() => 'Shooter';

  change(String n) => state = n;
}