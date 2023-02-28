import 'package:flame/components.dart';

class PaintBucket extends SpriteComponent {
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
}
