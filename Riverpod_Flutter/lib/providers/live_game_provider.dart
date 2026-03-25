import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_flutter/models/game.dart';
import 'package:riverpod_flutter/source/game_source.dart';

part 'live_game_provider.g.dart';

@riverpod
class LiveGameNotifier extends _$LiveGameNotifier {
  @override
  // Cara 1 tanpa LiveGameState
  // List<Game> build() => <Game>[];
  // Cara 2 LiveGameState
  LiveGameState build() => LiveGameState('', '', []);

  fetchLiveGame() async{
    // Cara 1
    // final games = await GameSource.getLive();
    // if(games==null){
    //   return;
    // }
    //
    // state = games;

    // Cara 2
    state = LiveGameState('loading', '', []);
    await Future.delayed(const Duration(seconds: 2));
    final games = await GameSource.getLive();
    if(games==null){
      state = LiveGameState('failed', 'Something went wrong', []);
    }else{
      state = LiveGameState('success', '', games);
    }

    print("State : $state");
  }
}

class LiveGameState extends Equatable{
  final String status;
  final String messageError;
  final List<Game> data;

  LiveGameState(this.status, this.messageError, this.data);

  @override
  List<Object> get props => [status, messageError, data];
}