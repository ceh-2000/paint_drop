import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';

class Star extends PositionComponent with DragCallbacks {
  Star({
    required int n,
    required double radius1,
    required double radius2,
    required double sharpness,
    required this.color,
    required double speed,
    required double game_width,
    super.position,
  }) {
    _path = Path()..moveTo(radius1, 0);
    for (var i = 0; i < n; i++) {
      final p1 = Vector2(radius2, 0)..rotate(tau / n * (i + sharpness));
      final p2 = Vector2(radius2, 0)..rotate(tau / n * (i + 1 - sharpness));
      final p3 = Vector2(radius1, 0)..rotate(tau / n * (i + 1));
      _path.cubicTo(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
    }
    _path.close();

    _speed = speed;
    _game_width = game_width;
    _star_size = radius1;
}

  final Color color;
  final Paint _paint = Paint();
  final Paint _borderPaint = Paint()
    ..color = const Color(0xFFffffff)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  final _shadowPaint = Paint()
    ..color = const Color(0xFF000000)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

  late final Path _path;
  late final double _speed;
  late final double _game_width;
  late final double _star_size;
  bool _isDragged = false;

  @override
  bool containsLocalPoint(Vector2 point) {
    // Checks when we intersect with where the user is tapping
    // Supports dragging functionality
    return _path.contains(point.toOffset());
  }

  @override
  void render(Canvas canvas) {
    // While star is being dragged, indicate this with shadows and a border
    if (_isDragged) {
      _paint.color = color.withOpacity(0.5);
      canvas.drawPath(_path, _paint);
      canvas.drawPath(_path, _borderPaint);
    }
    // When not dragging, star is normal
    else {
      _paint.color = color.withOpacity(1);
      canvas.drawPath(_path, _shadowPaint);
      canvas.drawPath(_path, _paint);
    }
  }

  @override
  void update(double dt) {
    // Use the amount of time that has elapsed to inform position for smooth movement
    super.update(dt);
    position = Vector2(position.x, position.y + _speed * dt);

    // Pause spinning when dragging stars
    if(_isDragged == false){
      angle += dt * 2;
      angle %= 2 * pi;
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    _isDragged = true;
    priority = 10; // Brings star to front of overlap
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    priority = 0; // Return to default depth
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // While user is dragging and we intersect motion with star, update star position
    double new_pos = position.x + event.delta.x;

    // Don't let star get dragged beyond right side bounds
    if(new_pos > _game_width - _star_size){
      new_pos = _game_width - _star_size;
    }

    // Don't let star get dragged beyond left side bounds
    else if(new_pos < _star_size){
      new_pos = _star_size;
    }

    // Set the new x-position; y-position stays the same
    position = Vector2(new_pos, position.y);
  }
}

const tau = 2 * pi;
