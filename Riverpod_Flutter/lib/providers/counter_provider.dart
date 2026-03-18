import 'package:riverpod_annotation/riverpod_annotation.dart';

// run in terminal   dart run build_runner watch -d
part 'counter_provider.g.dart';

// alt+enter in CounterNotifier -> add build method
@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() => 0;

  increment() => state++;
  decrement() => state--;
}