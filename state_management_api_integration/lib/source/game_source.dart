import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:state_management_api_integration/model/game.dart';
import 'package:http/http.dart' as http;

class GameSource {
  static Future<List<Game>?> getLive() async {
    String url = 'https://www.freetogame.com/api/games';

    try{
      final response = await http.get(Uri.parse(url));
      print('RESPONSE API: ${response.statusCode.toString()}');
      if(response.statusCode==200){
        // Penggunaan List karena response api di mulai dengan [ ]
        List list = jsonDecode(response.body);
        // convert List dynamic to List<Game>
        List<Game> games = list.map((e) => Game.fromJson(Map.from(e))).toList();
        return games;
      }else{
        return null;
      }
    }catch (e){
      debugPrint(e.toString());
      return null;
    }
  }
}