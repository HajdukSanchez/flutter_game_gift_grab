import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '/games/gift_grab_game.dart';
import '/screens/game_over_menu.dart';

/// Unique instance of the game
final GiftGrabGame _giftGrabGame = GiftGrabGame();

/// Widget to handle game creation and overlay menu inside the game
class GamePlay extends StatelessWidget {
  /// Constructor
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _giftGrabGame,
      overlayBuilderMap: {
        GameOverMenu.ID: (_, GiftGrabGame gameRef) =>
            GameOverMenu(gameRef: gameRef),
      },
    );
  }
}
