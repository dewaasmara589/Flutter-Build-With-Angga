
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/models/game.dart';
import 'package:riverpod_flutter/providers/genre_provider.dart';
import 'package:riverpod_flutter/providers/live_game_provider.dart';

class LiveGamePage extends ConsumerStatefulWidget {
  const LiveGamePage({super.key});

  @override
  ConsumerState<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends ConsumerState<LiveGamePage>{

  List<String> genres = [
    'Shooter',
    'MMOARPG',
    'ARPG',
    'Strategy',
    'Fighting',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(liveGameNotifierProvider.notifier).fetchLiveGame();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Game'),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, wiRef, child){
              // Cara 1
              // String genreSelected = wiRef.watch(genreProvider);
              
              // Cara 2
              String genreSelected = wiRef.watch(genreNotifierProvider);
              
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: genres.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ActionChip(
                          onPressed: (){
                            ref.read(genreNotifierProvider.notifier).change(e);
                          },
                          label: Text(
                            e,
                            style: TextStyle(
                              color: genreSelected == e ? Colors.white : Colors.black,
                            ),
                          ),
                          backgroundColor: genreSelected == e ? Theme.of(context).primaryColor : Colors.white,

                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 8,),
          Expanded(
            child: Consumer(
                builder: (context, wiRef, child) {
                  // Cara 1 tanpa LiveGameState
                  // List<Game> games = wiRef.watch(liveGameNotifierProvider);

                  // Cara 2 LiveGameState
                  LiveGameState state = wiRef.watch(liveGameNotifierProvider);
                  if(state.status=='') return const SizedBox.shrink();
                  if(state.status=='loading') {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(state.status=='failed') {
                    return Center(
                      child: Text(state.messageError),
                    );
                  }

                  List<Game> list = state.data;
                  String generatedSelected = wiRef.watch(genreNotifierProvider);

                  // Cara 1 tanpa filter genre
                  // List<Game> games = state.data;

                  // Cara 2
                  List<Game> games = list.where((_element) => _element.genre == generatedSelected).toList();

                  return GridView.builder(
                    itemCount: games.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 3.0,
                      ),
                      itemBuilder: (context, index) {
                        Game game = games[index];
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: ExtendedImage.network(
                                // ! untuk error agument String?
                                game.thumbnail!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: AlignmentGeometry.bottomCenter,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: AlignmentGeometry.bottomCenter,
                                    end: AlignmentGeometry.topCenter,
                                    colors: [
                                      Colors.black,
                                      Colors.transparent
                                    ]
                                  )
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentGeometry.bottomRight,
                              child: IconButton(
                                  onPressed: (){
                                    ref.read(liveGameNotifierProvider.notifier)
                                        .changeIsSaved(game.copyWith(isSaved: !game.isSaved));
                                  },
                                  icon: game.isSaved? const Icon(Icons.bookmark, color: Colors.blue,) : const Icon(Icons.bookmark_border, color: Colors.white,)
                              )
                            )
                          ],
                        );
                      }
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}