import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_christmas_gift/constants/sounds_constants.dart';

import '/components/gift_component.dart';
import '/inputs/draggable_inputs.dart';
import '/components/santa_component.dart';
import '/components/background_component.dart';

/// Class to handle game canvas to render game and user interaction
class GiftGrabGame extends FlameGame with HasDraggables, HasCollisionDetection {
  late JoystickComponent _joyStick;
  int score = 0; // Score of boxes recollected

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _joyStick = DraggableInputs.joystick;

    // Add background sprite to game canvas
    add(BackgroundComponent());
    // Add santa player to game canvas
    add(SantaComponent(joyStick: _joyStick));
    // Add joystick for interaction
    add(_joyStick);
    // Add gift box component
    add(GiftComponent());

    // Initialize audio data
    FlameAudio.audioCache.loadAll([
      SoundsConstants.itemGrabSound,
    ]);
  }
}
