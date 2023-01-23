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
  Future<void> onLoad() async {
    for (var i = 0; i < 500; i = i + 50) {
      // Create a new random number
      Random rnd = Random();
      int padding = 50;
      int min = padding;
      int max = WidgetsBinding.instance.window.physicalSize.width.toInt() - padding;
      int r = min + rnd.nextInt(max - min);

      add(Star(
        n: 5,
        radius1: 20,
        radius2: 10,
        sharpness: 0.2,
        color: const Color(0xffbae5ad),
        position: Vector2(r.toDouble(), -i.toDouble()),
      ));
    }
  }
}
