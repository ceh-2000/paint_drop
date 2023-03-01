import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PaintBucket extends SpriteComponent with CollisionCallbacks {
  PaintBucket({
    super.sprite,
    super.position,
    super.size,
    super.anchor,
    required String color,
  }) {
    _color = color;
  }

  late final String _color;

  String getColor() {
    return _color;
  }

  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
  }
}
