import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

/// Inputs to handle draggable interaction of the user with the game components
class DraggableInputs {
  static const double _joystickRadius = 20;

  /// JoyStick to move and handle
  static JoystickComponent joystick = JoystickComponent(
    knob: CircleComponent(
      radius: _joystickRadius,
      paint: BasicPalette.red.withAlpha(200).paint(),
    ),
    background: CircleComponent(
      radius: _joystickRadius * 2,
      paint: BasicPalette.red.withAlpha(100).paint(),
    ),
    margin: const EdgeInsets.only(
      right: 40,
      bottom: 40,
    ),
  );
}
