import 'dart:ui';

import 'package:flame/game.dart';
import 'paint_drop.dart';
import 'paint_bucket.dart';
import 'paint_background.dart';

class PaintGame extends FlameGame{
  PaintBucket _bucket = PaintBucket();
  PaintDrop _drop = PaintDrop();
  PaintWorld _world = PaintWorld();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    await add(_bucket);
    await add(_drop);


    // _drop.position = _world.size / 3;
    // _bucket.position = _world.size / 2;
    // camera.followComponent(_drop,
    //     worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }
}