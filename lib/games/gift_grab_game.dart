import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '/components/ice_component.dart';
import '/constants/sounds_constants.dart';
import '/components/gift_component.dart';
import '/inputs/draggable_inputs.dart';
import '/components/santa_component.dart';
import '/components/background_component.dart';

/// Class to handle game canvas to render game and user interaction
class GiftGrabGame extends FlameGame with HasDraggables, HasCollisionDetection {
  late JoystickComponent _joyStick;
  late Timer _timer;
  late TextComponent _scoreText;
  late TextComponent _timeText;
  int remainingTime = 30; // 30 seconds of play
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
    // Add ice's component
    addAll([
      IceComponent(startPosition: Vector2(200, 200)),
      IceComponent(startPosition: Vector2(size.x - 200, size.y - 200)),
    ]);
    // Component that detects any collision on the boundaries of the viewport
    add(ScreenHitbox());

    // Initialize audio data
    FlameAudio.audioCache.loadAll([
      SoundsConstants.itemGrabSound,
      SoundsConstants.freezeSound,
    ]);

    _addScreenTexts();

    _timer = Timer(1, repeat: true, onTick: () {
      if (remainingTime == 0) {
        // Pause de game
        pauseEngine();
      } else {
        remainingTime--;
      }
    });
    _timer.start();
  }

  // Add texts to the screen with some information
  void _addScreenTexts() {
    _scoreText = TextComponent(
      text: 'Score $score',
      position: Vector2(40, 60),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );

    _timeText = TextComponent(
      text: 'Time $remainingTime s',
      position: Vector2(size.x - 40, 60),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );

    addAll([_scoreText, _timeText]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _timer.update(dt);

    _scoreText.text = getScoreText();
    _timeText.text = getTimerText();
  }

  /// Get text with updated score value
  String getScoreText() => 'Score $score';

  /// Get text with updated Timer value
  String getTimerText() => 'Time $remainingTime s';
}
