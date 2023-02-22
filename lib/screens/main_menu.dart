import 'package:flutter/material.dart';

import '/screens/game_play.dart';
import '/constants/images_constants.dart';

/// Menu of the Game to show at the top of the screen
class MainMenu extends StatelessWidget {
  /// Constructor
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/${ImagesConstants.bgSprite}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Gift Grab',
                  style: TextStyle(fontSize: 50),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the game
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const GamePlay()));
                },
                child: const Text(
                  'Play',
                  style: TextStyle(fontSize: 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
