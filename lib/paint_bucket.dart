import 'package:flame/components.dart';

class PaintBucket extends SpriteComponent with HasGameRef{
  PaintBucket() : super(size: Vector2.all(100.0), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('red_bucket.png');
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = Vector2(gameSize.x / 2, gameSize.y - 70.0);
  }
}