import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_api_integration/model/game.dart';
import 'package:state_management_api_integration/provider/game_provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<GameProvider>().fetchLiveGame();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Games'),
        centerTitle: true,
      ),
      body: Consumer<GameProvider>(
          builder: (context, gameProvider, child){
            if(gameProvider.status == GameStatus.loading){
              return Center(child: CircularProgressIndicator(),);
            }
            if(gameProvider.status == GameStatus.failure){
              return Center(child: Text('Something Went Wrong'));
            }
            if(gameProvider.status == GameStatus.loaded){
              List<Game> games = gameProvider.games;
              return GridView.builder(
                itemCount: games.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2
                ),
                itemBuilder: (context, index){
                  Game game = games[index];
                  return ExtendedImage.network(
                    game.thumbnail??'',
                    fit: BoxFit.cover,
                  );
                },
              );
            }
            return SizedBox.shrink();
          }
      ),
    );
  }
}
