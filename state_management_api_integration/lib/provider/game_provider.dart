import 'package:flutter/cupertino.dart';
import 'package:state_management_api_integration/source/game_source.dart';

import '../model/game.dart';

enum GameStatus {init, loading, loaded, failure}

class GameProvider extends ChangeNotifier {
  String genre = 'Shooter';

  setGenre(String n){
    genre = n;
    notifyListeners();
  }

  GameStatus status = GameStatus.init;

  List<Game> _games = [];
  List<Game> get games => _games;

  fetchLiveGame() async{
    status = GameStatus.loading;
    notifyListeners();

    final list = await GameSource.getLive();
    if(list == null){
      await Future.delayed(Duration(seconds: 2));
      status = GameStatus.failure;
      notifyListeners();
      return;
    }

    _games = list!;
    status = GameStatus.loaded;
    notifyListeners();
  }
}