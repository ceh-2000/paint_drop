import 'dart:math';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:paint_drop/star.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}


class MyGame extends FlameGame with HasDraggableComponents {
  @override
  Color backgroundColor() => const Color(0xFF003366);

  @override
  Future<void> onLoad() async {
    // Constants
    int number_of_stars = 20;
    int pixels_between_stars = 100;
    double size_of_star = 30;

    // Use a for-loop
    for (var i = 0; i < number_of_stars * pixels_between_stars; i = i + pixels_between_stars) {
      // Create a new random number
      Random rnd = Random();
      int min = size_of_star.toInt();
      int max = (size.x.toInt() - size_of_star).toInt();
      int r = min + rnd.nextInt(max - min);

      // Create new stars positioned evenly height-wise and randomly width-wise
      add(Star(
        n: 5,
        radius1: size_of_star,
        radius2: size_of_star / 2,
        sharpness: 0.2,
        color: const Color(0xFFFDE992),
        speed: 10.0,
        game_width: size.x,
        position: Vector2(r.toDouble(), -i.toDouble()),
      ));
    }
  }
}
