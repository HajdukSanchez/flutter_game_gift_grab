import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '/components/santa_component.dart';
import '/constants/sounds_constants.dart';
import '/constants/images_constants.dart';
import '/games/gift_grab_game.dart';

/// Gift box to show on the screen
///
/// The mixin [HasGameRef] allow us to connect this sprite with a specific game
/// in order to be able to get game information and properties
class GiftComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = 100;
  final Random _randomPosition = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load the sprite image
    sprite = await gameRef.loadSprite(ImagesConstants.giftSprite);
    // Box size
    height = width = _spriteHeight;
    // Box position
    position = _getRandomPosition();
    // Component anchor position
    anchor = Anchor.center;

    // Add a special component
    // This component allow us to know when this component is interaction with another component
    // Without this component collision is not possible
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is SantaComponent) {
      // Play grab sound
      FlameAudio.play(SoundsConstants.itemGrabSound);
      // Remove this component from the parent (remove from the game screen)
      removeFromParent();
      gameRef.score++;
      // Add another [GiftComponent] randomly in the parent game screen
      gameRef.add(GiftComponent());
    }
  }

  // Method to set a random position of the component into the game screen
  Vector2 _getRandomPosition() {
    // Get random x position based on game x screen
    double x = _randomPosition.nextInt(gameRef.size.x.toInt()).toDouble();
    // Get random y position based on game y screen
    double y = _randomPosition.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}
