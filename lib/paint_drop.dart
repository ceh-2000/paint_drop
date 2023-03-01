import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:paint_drop/paint_bucket.dart';

class PaintDrop extends SpriteComponent with DragCallbacks, CollisionCallbacks {
  PaintDrop({
    super.sprite,
    super.position,
    super.size,
    super.anchor,
    required double speed,
    required double game_width,
    required String color,
  }) {
    _speed = speed;
    _game_width = game_width;
    _color = color;
    _buffer = size[0];
  }

  late final double _speed;
  late final double _game_width;
  late final String _color;
  late final double _buffer;

  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // Use the amount of time that has elapsed to inform position for smooth movement
    super.update(dt);
    position = Vector2(position.x, position.y + _speed * dt);
  }

  @override
  void onDragStart(DragStartEvent event) {
    priority = 10; // Brings star to front of overlap
  }

  @override
  void onDragEnd(DragEndEvent event) {
    priority = 0; // Return to default depth
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // While user is dragging and we intersect motion with star, update star position
    double new_pos = position.x + event.delta.x;

    // Don't let star get dragged beyond right side bounds
    if (new_pos > _game_width - _buffer) {
      new_pos = _game_width - _buffer;
    }

    // Don't let star get dragged beyond left side bounds
    else if (new_pos < _buffer) {
      new_pos = _buffer;
    }

    // Set the new x-position; y-position stays the same
    position = Vector2(new_pos, position.y);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PaintBucket) {
      // Check the color
      if (other.getColor() == _color) {
        print("We have a match!");
      } else {
        print("Colors did not match :(");
      }

      // Remove the paint drop from the screen
      removeFromParent();
    }
  }
}
