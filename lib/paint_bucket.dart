import 'package:flame/components.dart';

class PaintBucket extends SpriteComponent with HasGameRef{
  PaintBucket() : super(size: Vector2.all(100.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('red_bucket.png');
    position = gameRef.size / 3;
  }
}