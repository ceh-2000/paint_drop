import 'package:flame/components.dart';
import 'dart:ui';

class PaintWorld extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('background.png');

    var physicalScreenSize = window.physicalSize;
    var physicalWidth = physicalScreenSize.width;
    var physicalHeight = physicalScreenSize.height;

    size = Vector2.array([physicalWidth, physicalHeight]);
  }
}