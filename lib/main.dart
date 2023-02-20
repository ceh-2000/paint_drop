import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:paint_drop/paint_bucket.dart';
import 'package:paint_drop/paint_drop.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

class MyGame extends FlameGame with HasDraggableComponents {
  @override
  Future<void> onLoad() async {
    // Constants
    int number_of_drops = 20;
    int pixels_between_drops = 100;
    double size_of_drop = 50;
    double size_of_bucket = 100;
    int num_colors = 4;

    // Load all images
    final redDrop = await images.load('red_drop.png');
    final blueDrop = await images.load('blue_drop.png');
    final pinkDrop = await images.load('pink_drop.png');
    final yellowDrop = await images.load('yellow_drop.png');

    final redBucket = await images.load('red_bucket.png');
    final blueBucket = await images.load('blue_bucket.png');
    final pinkBucket = await images.load('pink_bucket.png');
    final yellowBucket = await images.load('yellow_bucket.png');

    final background = await images.load('background.png');

    // Add the static background image
    add(SpriteComponent(
        sprite: Sprite(background),
        size: Vector2(size.x, size.y),
        position: Vector2(0, 0)));

    // Add the static paint buckets
    add(PaintBucket(
      sprite: Sprite(redBucket),
      position: Vector2(size.x * 0.2, size.y - size_of_bucket - 50),
      size: Vector2(size_of_bucket, size_of_bucket),
      anchor: Anchor.center,
    ));
    add(PaintBucket(
      sprite: Sprite(blueBucket),
      position: Vector2(size.x * 0.4, size.y - size_of_bucket - 50),
      size: Vector2(size_of_bucket, size_of_bucket),
      anchor: Anchor.center,
    ));
    add(PaintBucket(
      sprite: Sprite(pinkBucket),
      position: Vector2(size.x * 0.6, size.y - size_of_bucket - 50),
      size: Vector2(size_of_bucket, size_of_bucket),
      anchor: Anchor.center,
    ));
    add(PaintBucket(
      sprite: Sprite(yellowBucket),
      position: Vector2(size.x * 0.8, size.y - size_of_bucket - 50),
      size: Vector2(size_of_bucket, size_of_bucket),
      anchor: Anchor.center,
    ));

    // Add the paint drops using a for-loop
    for (var i = 0;
        i < number_of_drops * pixels_between_drops;
        i = i + pixels_between_drops) {
      // Create a random number to determine where along the x-axis the
      // paint drop should fall
      Random rnd_loc = Random();
      int min_loc = size_of_drop.toInt();
      int max_loc = (size.x.toInt() - size_of_drop).toInt();
      int r_loc = min_loc + rnd_loc.nextInt(max_loc - min_loc);

      // Create a random number to determine which color drop we create on
      // this iteration of the for-loop
      Random rnd_color = Random();
      int min_color = 1;
      int max_color = num_colors;
      int r_color = min_color + rnd_color.nextInt(max_color - min_color);

      // Create corresponding drop color
      Sprite sprite;
      String color;
      switch (r_color) {
        case 1:
          {
            sprite = Sprite(redDrop);
            color = 'red';
          }
          break;
        case 2:
          {
            sprite = Sprite(blueDrop);
            color = 'blue';
          }
          break;
        case 3:
          {
            sprite = Sprite(pinkDrop);
            color = 'pink';
          }
          break;
        default:
          {
            sprite = Sprite(yellowDrop);
            color = 'yellow';
          }
          break;
      }

      // Add the paint drop to our canvas
      add(PaintDrop(
          sprite: sprite,
          position: Vector2(r_loc.toDouble(), -i.toDouble()),
          size: Vector2(size_of_drop * 0.75, size_of_drop),
          anchor: Anchor.center,
          speed: 10.0,
          game_width: size.x,
          color: color));
    }
  }
}
