import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '/components/ice_component.dart';
import '/constants/sounds_constants.dart';
import '/constants/constants.dart';
import '/constants/images_constants.dart';
import '/games/gift_grab_game.dart';

/// Class to handle Santa player and his own properties and movements
///
/// We add a group of sprites, to handle a map of different sprites images based on some class
/// In this case sprite will we handle based on [SantaMovementStateType] enum
class SantaComponent extends SpriteGroupComponent<SantaMovementStateType>
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = 100;
  final double _spriteSpeed = 400;
  // Screen bound of the component
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  bool isFrozen = false;
  final Timer _timer = Timer(3); // How long santa is going to be frozen

  /// Constructor
  SantaComponent({required this.joyStick});

  /// Joystick to move Santa component
  final JoystickComponent joyStick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load the sprite images
    Sprite spriteIdle =
        await gameRef.loadSprite(ImagesConstants.santaIdleSprite);
    Sprite spriteLeftIdle =
        await gameRef.loadSprite(ImagesConstants.santaLeftIdleSprite);
    Sprite spriteRightIdle =
        await gameRef.loadSprite(ImagesConstants.santaRightIdleSprite);
    Sprite spriteSantaFrozen =
        await gameRef.loadSprite(ImagesConstants.santaFrozenSprite);
    // Set all the sprites images of the component
    sprites = {
      SantaMovementStateType.idle: spriteIdle,
      SantaMovementStateType.slideLeft: spriteLeftIdle,
      SantaMovementStateType.slideRight: spriteRightIdle,
      SantaMovementStateType.frozen: spriteSantaFrozen,
    };

    _setComponentBoundaries();
    current = SantaMovementStateType.idle;

    // Add sprite at the middle of the game object
    position = gameRef.size / 2;
    // Height of the sprite
    height = _spriteHeight;
    // Width of the sprite
    width = _spriteHeight * 1.42;
    // Set the initial position of the sprite in the middle of itself
    anchor = Anchor.center;

    // Add a special component
    // This component allow us to know when this component is interaction with another component
    // Without this component collision is not possible
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isFrozen) {
      if (joyStick.direction == JoystickDirection.idle) {
        current = SantaMovementStateType.idle;
        return;
      }

      _validateComponentBoundaries();
      _moveComponent();
      position.add(joyStick.relativeDelta * _spriteSpeed * dt);
    } else {
      // Update timer
      _timer.update(dt);

      if (_timer.finished) {
        _unFreezedSanta();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is IceComponent) {
      _freezeSanta();
    }
  }

  // Handle when santa is freeze
  void _freezeSanta() {
    if (!isFrozen) {
      // Sound frozen audio
      FlameAudio.play(SoundsConstants.freezeSound);
      // Set frozen state
      isFrozen = true;
      // Add frozen sprite image
      current = SantaMovementStateType.frozen;
    }
  }

  // Handle when santa is not freezed
  void _unFreezedSanta() {
    // Set frozen state
    isFrozen = false;
    // Add movement sprite image
    current = SantaMovementStateType.idle;
  }

  // Set components boundaries
  void _setComponentBoundaries() {
    const double defaultHorizontal = 45;
    const double defaultVertical = 55;

    _rightBound = gameRef.size.x - defaultHorizontal;
    _leftBound = defaultHorizontal;
    _upBound = defaultVertical;
    _downBound = gameRef.size.y - defaultVertical - 30;
  }

  // Validate if component is try to get out of the bounds
  // bounds came from the game class
  void _validateComponentBoundaries() {
    // Avoid right outbound
    if (x >= _rightBound) x = _rightBound - 1;
    // Avoid left outbound
    if (x <= _leftBound) x = _leftBound + 1;
    // Avoid up outbound
    if (y <= _upBound) y = _upBound + 1;
    // Avoid down outbound
    if (y >= _downBound) y = _downBound - 1;
  }

  // Validate component movement in the game screen
  void _moveComponent() {
    bool isMovingLeft = joyStick.relativeDelta[0] < 0;
    current = isMovingLeft
        ? SantaMovementStateType.slideLeft
        : SantaMovementStateType.slideRight;
  }
}
