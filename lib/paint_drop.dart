import 'package:flame/components.dart';

class PaintDrop extends SpriteComponent with HasGameRef{
  PaintDrop(String image_name) : super(size: Vector2.array([20.0, 30.0]), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite("red_drop.png");
  }
}