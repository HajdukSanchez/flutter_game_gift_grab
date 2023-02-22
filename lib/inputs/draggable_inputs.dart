import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

/// JoyStick default radius
const double _joystickRadius = 20;

/// JoyStick to move and handle
JoystickComponent joystick = JoystickComponent(
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
