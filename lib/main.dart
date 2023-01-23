import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:paint_drop/paint_game.dart';

void main() {
  final game = PaintGame();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}