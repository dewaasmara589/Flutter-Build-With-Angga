
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/models/game.dart';
import 'package:riverpod_flutter/providers/live_game_provider.dart';

class LiveGamePage extends ConsumerStatefulWidget {
  const LiveGamePage({super.key});

  @override
  ConsumerState<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends ConsumerState<LiveGamePage>{

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
      body: Consumer(
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
            List<Game> games = state.data;

            return GridView.builder(
              itemCount: games.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  Game game = games[index];
                  return ExtendedImage.network(
                    // ! untuk error agument String?
                    game.thumbnail!,
                    fit: BoxFit.cover,
                  );
                }
            );
          }
      ),
    );
  }
}