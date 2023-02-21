import 'package:flame/components.dart';

import '/constants/constants.dart';
import '/constants/images_constants.dart';
import '/games/gift_grab_game.dart';

/// Class to handle Santa player and his own properties and movements
///
/// We add a group of sprites, to handle a map of different sprites images based on some class
/// In this case sprite will we handle based on [SantaMovementStateType] enum
class SantaComponent extends SpriteGroupComponent<SantaMovementStateType>
    with HasGameRef<GiftGrabGame> {
  final double _spriteHeight = 200;
  final double _spriteSpeed = 400;
  // Screen bound of the component
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

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
    // Set all the sprites images of the component
    sprites = {
      SantaMovementStateType.idle: spriteIdle,
      SantaMovementStateType.slideLeft: spriteLeftIdle,
      SantaMovementStateType.slideRight: spriteRightIdle,
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
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (joyStick.direction == JoystickDirection.idle) {
      current = SantaMovementStateType.idle;
      return;
    }

    _validateComponentBoundaries();
    _moveComponent();
    position.add(joyStick.relativeDelta * _spriteSpeed * dt);
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
