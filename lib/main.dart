import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '/games/gift_grab_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(game: GiftGrabGame()),
    );
  }
}
