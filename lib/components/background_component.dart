import 'package:flame/components.dart';

import '/constants/images_constants.dart';
import '/games/gift_grab_game.dart';

/// Background parallax of the game
///
/// The mixin [HasGameRef] allow us to connect this sprite with a specific game
/// in order to be able to get game information and properties
class BackgroundComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load the sprite image
    sprite = await gameRef.loadSprite(ImagesConstants.bgSprite);
    // Size of the background (all the screen game size)
    size = gameRef.size;
  }
}
