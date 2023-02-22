import 'package:flutter/material.dart';

import '/constants/images_constants.dart';
import '/games/gift_grab_game.dart';

/// Menu of the Game to show at the top of the screen
class GameOverMenu extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ID = 'GameOverMenu';

  /// Constructor
  const GameOverMenu({
    super.key,
    required this.gameRef,
  });

  /// Reference of the game to use the widget
  final GiftGrabGame gameRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/${ImagesConstants.bgSprite}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Game Over',
                  style: TextStyle(fontSize: 50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  'Score: ${gameRef.score}',
                  style: const TextStyle(fontSize: 50),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Remove this widget form the screen
                  gameRef.overlays.remove(GameOverMenu.ID);
                  // Reset the game state to play again
                  // TODO: ADD reset game
                  // Start again movement of the game
                  gameRef.resumeEngine();
                },
                child: const Text(
                  'Play Again ?',
                  style: TextStyle(fontSize: 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
