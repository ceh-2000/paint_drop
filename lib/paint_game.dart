import 'dart:ui';

import 'package:flame/game.dart';
import 'paint_drop.dart';
import 'paint_bucket.dart';

class PaintGame extends FlameGame{
  PaintBucket _bucket = PaintBucket();
  PaintDrop _drop = PaintDrop("blue_drop.png");

  @override
  Color backgroundColor() => const Color(0xFFFCF5E5);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_bucket);
    await add(_drop);
  }
}