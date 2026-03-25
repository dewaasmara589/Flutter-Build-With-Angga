import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_flutter/models/game.dart';

class GameSource {
  // ? untuk error null
  static Future<List<Game>?> getLive() async {
    try{
      String url = 'https://www.freetogame.com/api/games';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36',
          'Accept': 'application/json',
          'Accept-Language': 'en-US,en;q=0.9',
          'Referer': 'https://freetogame.com',
          'Connection': 'keep-alive',
        },
      ).timeout(Duration(seconds: 30));
      print("RUN API - ${response.statusCode}");
      if(response.statusCode==200){
        List list = jsonDecode(response.body);
        // list modifikasi ke map lalu ke model Game, return toList karena map iterable
        return list.map((e) => Game.fromJson(Map.from(e))).toList();
      }

      return null;
    }catch(e){
      print("Error fetching games: $e");
      return null;
    }
  }
}