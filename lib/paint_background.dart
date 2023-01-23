import 'package:flame/components.dart';
import 'dart:ui';

class PaintWorld extends SpriteComponent with HasGameRef {
  PaintWorld() : super(size: Vector2.array([window.physicalSize.width, window.physicalSize.height]));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('background.png');
    size = sprite!.originalSize;
  }
}