import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '/constants/images_constants.dart';
import '/games/gift_grab_game.dart';

class IceComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = 100;
  late Vector2 _velocity;
  double speed = 100;
  double degree = math.pi / 180;

  /// Constructor
  IceComponent({required this.startPosition});

  /// Initial position of the component
  final Vector2 startPosition;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load the sprite image
    sprite = await gameRef.loadSprite(ImagesConstants.iceSprite);
    // Ice size
    height = width = _spriteHeight;
    // Ice position
    position = startPosition;
    // Component anchor position
    anchor = Anchor.center;

    double spawnAngle = _getSpawnAngle();
    final double vx = math.cos(spawnAngle * degree) * speed;
    final double vy = math.sin(spawnAngle * degree) * speed;

    _velocity = Vector2(vx, vy);

    // Component to handle collision
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ScreenHitbox) {
      // Get first collision points with screen viewport
      final Vector2 collisionPoint = intersectionPoints.first;

      // If collision is on the left or Right side of the screen
      if (collisionPoint.x == 0 || collisionPoint.x == gameRef.size.x) {
        // Go oposite
        _velocity.x = -_velocity.x;
        _velocity.y = _velocity.y;
      }

      // If collision is on the Up or Down side of the screen
      if (collisionPoint.y == 0 || collisionPoint.y == gameRef.size.y) {
        // Go oposite
        _velocity.x = _velocity.x;
        _velocity.y = -_velocity.y;
      }
    }
  }

  // Get an angle when ice spawn with the limit if the screen
  double _getSpawnAngle() {
    final random = math.Random().nextDouble();
    final spawnAngle = lerpDouble(0, 360, random)!;
    return spawnAngle;
  }
}
