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
  bool _isDragged = false;
  int _speed = 10;

  @override
  bool containsLocalPoint(Vector2 point) {
    return _path.contains(point.toOffset());
  }

  @override
  void render(Canvas canvas) {
    if (_isDragged) {
      _paint.color = color.withOpacity(0.5);
      canvas.drawPath(_path, _paint);
      canvas.drawPath(_path, _borderPaint);
    } else {
      _paint.color = color.withOpacity(1);
      canvas.drawPath(_path, _shadowPaint);
      canvas.drawPath(_path, _paint);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = Vector2(position.x, position.y + _speed * dt);
    angle += dt * 2;
    angle %= 2 * pi;
  }

  @override
  void onDragStart(DragStartEvent event) {
    _isDragged = true;
    priority = 10;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    priority = 0;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position = Vector2(position.x + event.delta.x, position.y);
  }
}

const tau = 2 * pi;
