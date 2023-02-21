import 'package:flame/game.dart';

import '/inputs/draggable_inputs.dart';
import '/components/santa_component.dart';
import '/components/background_component.dart';

/// Class to handle game canvas to render game and user interaction
class GiftGrabGame extends FlameGame with HasDraggables {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Add background sprite to game canvas
    add(BackgroundComponent());
    // Add santa player to game canvas
    add(SantaComponent(joyStick: DraggableInputs.joystick));
    // Add joystick for interaction
    add(DraggableInputs.joystick);
  }
}
