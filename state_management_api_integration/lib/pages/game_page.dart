import 'package:d_method/d_method.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_api_integration/model/game.dart';
import 'package:state_management_api_integration/provider/game_provider.dart';
import 'package:state_management_api_integration/provider/genre_provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> genres = [
    'Shooter',
    'MMOARPG',
    'ARPG',
    'Strategy',
    'Fighting'
  ];

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
      body: Column(
        children: [
          Builder(
            builder: (context) {
              DMethod.log('-'*30);
              DMethod.log('Build Genres');

              // CARA 1
              // String genreSelected = context.watch<GenreProvider>().value;

              // CARA 2
              String genreSelected = context.select((GameProvider gameProvider) => gameProvider.genre);

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: genres.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ActionChip(
                          onPressed: () {
                            // CARA 1
                            // context.read<GenreProvider>().value = e;

                            // CARA 2
                            context.read<GameProvider>().setGenre(e);
                          },
                          backgroundColor: genreSelected == e ? Theme.of(context).primaryColor : Colors.white,
                          label: Text(e),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }
          ),
          SizedBox(height: 8.0,),
          Expanded(
            child: Consumer<GameProvider>(
                builder: (context, gameProvider, child){
                  if(gameProvider.status == GameStatus.loading){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(gameProvider.status == GameStatus.failure){
                    return Center(child: Text('Something Went Wrong'));
                  }
                  if(gameProvider.status == GameStatus.loaded){
                    List<Game> list = gameProvider.games;

                    // CARA 1
                    // String genreSelected = context.watch<GenreProvider>().value;

                    // CARA 2
                    String genreSelected = gameProvider.genre;

                    // Cara 1 tanpa filter genre
                    // List<Game> games = gameProvider.games;

                    // Cara 2 dengan filter genre
                    List<Game> games = list.where((e) => e.genre == genreSelected ).toList();

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
          ),
        ],
      ),
    );
  }
}
