# Paint Drop App for W&M Spring 2023 (GDSC)

Flutter game app to demonstrate game design and app development basics.

The presentation that accompanies this repository is [here](https://docs.google.com/presentation/d/164_ThDXfw_-uM7lYJTq7KEzJL6aox_4M/edit?usp=sharing&ouid=105181047619494018000&rtpof=true&sd=true).

## Prerequisites 
1. Install a code editor like [Android Studio](https://developer.android.com/studio?gclid=CjwKCAiA2rOeBhAsEiwA2Pl7Q12WSa4Wl206GuOh9YzMBcimmrDEISP9rX89B50LeVaQ0pRYUO6TkRoCe3EQAvD_BwE&gclsrc=aw.ds) or [VS Code](https://code.visualstudio.com/download).
2. Install Flutter using [this](https://docs.flutter.dev/get-started/install?gclid=CjwKCAiA2rOeBhAsEiwA2Pl7Q_iIJ4SSU8DQrpevxX2g4hXcDft6TKVtt3ydtIwAqI1gckdWDbp-zhoCKU0QAvD_BwE&gclsrc=aw.ds) guide.
3. Open terminal. Run `flutter doctor` to make sure everything is working as expected. Make sure you have green checkmarks by Flutter, Android toolchain, Chrome, and VS Code/Android Studio. If you want to run your app using iOS, also make sure you have a green checkmark next to Xcode.
4. Follow the instructions in the guide from step 2 to set up emulators/devices for Android, iOS, and/or Chrome.
Note: The first time you run your app on an iOS device, you need to do it through Xcode by right-clicking `ios` from the sidebar and selecting `Flutter/Open iOS module in Xcode`. Afterwards, you can run your app from Android Studio like normal.

> ❗️⚠️ If running `flutter` commands aren't recognized you need to add the `flutter/bin` folder to PATH. For instructions see [MacOS](https://docs.flutter.dev/get-started/install/macos#update-your-path), [Windows](https://docs.flutter.dev/get-started/install/windows#update-your-path), or [Linux](https://docs.flutter.dev/get-started/install/linux#update-your-path) .
   
## Creating your first app (Workshop 1)
1. In terminal, create an app using `flutter create paint_drop`
2. Navigage to your project folder using `cd paint_drop`
3. Complete setup with `flutter run`
4. Open your project to edit the code
   ```
   open . -a "Android Studio"
   ```
   Replace "Android Studio" with "VS Code" if using that instead. 
5. In the side menu at the top, click on ``Android" and select ``Project" from the dropdown menu to open your project as a Flutter project. If you already have ``Project" listed, don't change anything. Then in the side menu, delete the following directories: `macos`, `linux`, `windows`, and `test`.
6. Create a new directory called `assets` and within assets another directory called `images`. The results project path should be `paint_drop/assets/images`. Drop the game images into this new folder. 
7. Point your app to this images folder by opening the `pubspec.yaml` file located at the project root, scrolling down, and adding:
```
  flutter:
    assets:
      - assets/images/
```
8. Run `flutter pub get` to get these changes.
9. Run your app on your chosen device. I usually start with Chrome (web) because it takes the least amount of time to start. You should have a simple, blue button pushing app.   
10. Back in your code editor, open `lib/main.dart`. Try changing your theme to a different color palette by changing `primarySwatch: Colors.blue` to some other color scheme, e.g., `Colors.pink`.
9. Hot restart your app to see the theme change. In Android Studio, do this by clicking the `Run` tab at the bottom and then the green rectangle arrow icon. 
10. Change the app title and remove the debug banner in the top right by adding the following flag in `main.dart`:
```
    return MaterialApp(
      title: 'Paint Drop',
      debugShowCheckedModeBanner: false,
```
Also change the app screen name `home: const MyHomePage(title: 'Paint Drop'),`

## Flame game engine basics (Workshop 2)
1. Open `pubspec.yaml` from the project directory. Change the description to `Basic Flutter game app.`    
2. Add the [`flame`](https://pub.dev/packages/flame) as a package as follows:    
```
dependencies:
  flutter:
    sdk: flutter
  flame: ^1.6.0
```
Check the [docs](https://pub.dev/packages/flame) for the latest version.   

3. Run `flutter pub get` from terminal to install the new dependencies or click `Pub get` in the upper right corner if you are using Android Studio.    

4. Run your app using your desired device.
 
5. Navigate to the `lib` folder and open `main.dart`. Delete everything in this file. We want to create a new game instance.

6. Add the following imports to the top of `main.dart`:
```
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
```
These allow us to use Flame's game packages and the Material theming packages with Flutter.   

7. Now define a new `main` function as follows that will get executed first when you run your app:
```
void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}
```  

8. Android Studio (or the IDE of your choice) will yell at you and say `MyGame` is not defined, so outside of the `main` function, define the `MyGame` class as follows:
```
class MyGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF003366);
}
```
All we have added to the game so far is a background color instead of the default transparent background. Run your app, and you should have a dark blue background. Play around with changing the background color. Save your code and thanks to hot-reload, the new background color should render automatically.   

9. Navigate to the `lib` folder in the left menu (or via Terminal) and create a new file called `star.dart`.   

10. At the top, import the following: 
```
import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
```
These are the necessary `flame` and math packages we need to create the stars that will fall from the sky and be draggable.   

11. Next create a `Star` class that extends PositionComponent, which is a Flame game component with attributes for `position`, `size`, `scale`, `angle`, and `anchor`. We will instantiate the Star class as follows:
```
const tau = 2 * pi;
class Star extends PositionComponent {
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

  @override
  void render(Canvas canvas) {
    _paint.color = color.withOpacity(1);
    canvas.drawPath(_path, _shadowPaint);
    canvas.drawPath(_path, _paint);
  }

  @override
  void update(double dt) {
    // Use the amount of time that has elapsed to inform position for smooth movement
    super.update(dt);
    position = Vector2(position.x, position.y + _speed * dt);
  }
}
```
The first section is our constructor. This is where we accept arguments that describe how our stars should look from the parent class (in this case, the game controller). The next section describes variables we care about like the speed our stars will fall at, the width of the game, and the size of the stars. Finally, the `update` functions tells us how the stars should move. We want them to drop from above, so we use the elapsed time `dt` to compute the new y-position of the star while keeping the x-position the same.     

12. Reload the game, but nothing appears! We need to actually add the stars to our Flame Game. Do this by going back to the `main.dart` file and creating a new variable to track the size of the star and then adding the star to our game as follows directly under `Color backgroundColor() => const Color(0xFF003366);`:
```
  double size_of_star = 30;

  @override
  Future<void> onLoad() async {
    add(Star(
      n: 5,
      radius1: size_of_star,
      radius2: size_of_star / 2,
      sharpness: 0.2,
      color: const Color(0xFFFDE992),
      speed: 10.0,
      game_width: size.x,
      position: Vector2(50, 0),
    ));
    }
```
You should have one falling star that looks like this:   
<img width="300" alt="falling star" src="https://user-images.githubusercontent.com/34041975/217389417-27cb8be4-dc5f-4960-b366-a8ffb9dc8827.png">     
Play around with changing the color of the star, the starting position, adding more stars, etc.     

**CHALLENGE: Try and make the star travel from the left side of the screen to the right side.**

## Flame game draggable components (Workshop 3)
1. Now we want to make the elements of our game (the stars) draggable with the user's finger or mouse. A couple key things to consider:
- We only want the stars to be draggable horizontally while they continue to fall vertically like Tetris:
<img width="200" alt="Screenshot 2023-02-07 at 6 33 39 PM" src="https://user-images.githubusercontent.com/34041975/217391073-f6351997-5b89-468c-8963-0302c82c6f46.png">
- We don't want users to drag stars outside the bounds of the left or right sides of the screen.

**Question: How do we ensure these constraints? How do we make components draggable in the first place?**

Logic and [mixins](https://en.wikipedia.org/wiki/Mixin#:~:text=Mixins%20are%20a%20language%20concept,class%2C%20containing%20the%20desired%20functionality.)!

2. Change the class declaration in `main.dart` to `class MyGame extends FlameGame with HasDraggableComponents` enable draggable components in our game. Similarly, in `star.dart`, change the class declaration to `class Star extends PositionComponent with DragCallbacks`. 

3. Still in `star.dart`, add the following after `late final double _star_size;`, replacing the existing `render` and `update` functions:

```
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
```
If you stop and restart the app, you should have a single star falling from the sky that you can drag left and right horizontally and not beyond the bounds of the screen. 

4. To create more stars, update your `main.dart` file with the following: 
```
  @override
  Future<void> onLoad() async {
    // Constants
    int number_of_stars = 20;
    int pixels_between_stars = 100;
    double size_of_star = 30;

    // Use a for-loop
    for (var i = 0; i < number_of_stars * pixels_between_stars;
    i = i + pixels_between_stars) {
      // Create a new random number
      Random rnd = Random();
      int min = size_of_star.toInt();
      int max = (size.x.toInt() - size_of_star).toInt();
      int r = min + rnd.nextInt(max - min);

      // Create new stars positioned evenly height-wise and randomly width-wise
      add(Star(
        n: 5,
        radius1: size_of_star,
        radius2: size_of_star / 2,
        sharpness: 0.2,
        color: const Color(0xFFFDE992),
        speed: 10.0,
        game_width: size.x,
        position: Vector2(r.toDouble(), -i.toDouble()),
      ));
    }
  }
```
Make sure to import the math package at the top with the following line: `import 'dart:math';`.

5. Restart your code and the final app should look like this:

<img width="300" alt="Multiple falling, draggable stars" src="https://user-images.githubusercontent.com/34041975/217392806-b70a9182-2dfc-4435-bba3-a89897ea89ac.png">

## Adding images (Workshop 4)
1. In `main.dart`, add the following lines under `double size_of_star = 30;` to read in images previously added to our `assets` folder. If you don't have these files in place, follow the instructions for Workshop 1. 
```
    // Load all images
    final redDrop = await images.load('red_drop.png');
    final blueDrop = await images.load('blue_drop.png');
    final pinkDrop = await images.load('pink_drop.png');
    final yellowDrop = await images.load('yellow_drop.png');

    final redBucket = await images.load('red_bucket.png');
    final blueBucket = await images.load('blue_bucket.png');
    final pinkBucket = await images.load('pink_bucket.png');
    final yellowBucket = await images.load('yellow_bucket.png');
```
**Note: A cleaner implementation (and easier on the memory) would be to use the assets sheet `buckets_and_drops.png` and offset to the desired image. See how to do that [here](https://docs.flame-engine.org/1.6.0/flame/rendering/images.html#sprite). We don't have many images, so this isn't super necessary.**
2. Still in `main.dart`, comment out the code that adds a new `Star` to the screen. Paste in the following code to render our paint drop:
```
add(SpriteComponent(
   sprite: Sprite(redDrop),
   position: size / 2,
   size: Vector2(size_of_star*0.75, size_of_star),
   anchor: Anchor.center,
));
```
Save and reload your app. You should have what looks like a single red paint drop on your screen.
3. Now we want to create two new classes: one for paint drops and one for paint buckets. Don't worry about the `Star` class; we'll use the logic as a template for the paint drop class. In the `lib` folder create two new files called `paint_drop.dart` and `paint_bucket.dart`.
4. We want to move the logic from `main.dart` to our new class `paint_drop.dart` as follows:
- In `paint_drop.dart`, add the following:
```
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class PaintDrop extends SpriteComponent with DragCallbacks {
  PaintDrop({
    super.sprite,
    super.position,
    super.size,
    super.anchor,
  }){}
}
```
For now, we just pass everything to the parent construction, `SpriteComponent`.
- In `main.dart`, import `import 'package:paint_drop/paint_drop.dart';` at the top and comment out where we add the `SpriteComponent` and add the following:
```
add(PaintDrop(
   sprite: Sprite(redDrop),
   position: size / 2,
   size: Vector2(size_of_star * 0.75, size_of_star),
   anchor: Anchor.center,
));
```
Save and restart the app. It should look the same as before with just a single red paint drop in the middle of the screen.
5. With the `SpriteComponent` logic now in its own file, let's add back in the logic from `star.dart`. Modify `paint_drop.dart` to look like the following:
```
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class PaintDrop extends SpriteComponent with DragCallbacks {
  PaintDrop({
    super.sprite,
    super.position,
    super.size,
    super.anchor,
    required double speed,
    required double game_width,
  }){
    _speed = speed;
    _game_width = game_width;
    _buffer = size[0];
  }

  late final double _speed;
  late final double _game_width;
  late final double _buffer;


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
    if(new_pos > _game_width - _buffer){
      new_pos = _game_width - _buffer;
    }

    // Don't let star get dragged beyond left side bounds
    else if(new_pos < _buffer){
      new_pos = _buffer;
    }

    // Set the new x-position; y-position stays the same
    position = Vector2(new_pos, position.y);
  }
}
```
Most of the above code is directly copied from the `Star` class. Go back to the explanations for Workshops 2 & 3 if you are confused. If you try to save and reload the app, you will get errors because we have not passed in a `speed` or `game_width` to the `PaintDrop` object created in `main.dart`. Navigate to `main.dart` and make the following update:
```
add(PaintDrop(
   sprite: Sprite(redDrop),
   position: Vector2(r.toDouble(), -i.toDouble()),
   size: Vector2(size_of_star * 0.75, size_of_star),
   anchor: Anchor.center,
   speed: 10.0,
   game_width: size.x,
));
```
We also add back in the logic to make the paint drops appear at random along the width of the screen.
6. Now for some refactoring to add a background image and mutliple drop colors. The resulting `main.dart` file looks like this:
```
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
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
    add(SpriteComponent(
        sprite: Sprite(background),
        size: Vector2(size.x, size.y),
        position: Vector2(0, 0)));

    // Use a for-loop
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
```
and `paint_drop.dart` has the added `color` field like this:
```
PaintDrop({
    super.sprite,
    super.position,
    super.size,
    super.anchor,
    required double speed,
    required double game_width,
    required String color, // <-- HERE
  }){
    _speed = speed;
    _game_width = game_width;
    _color = color; // <-- HERE
    _buffer = size[0];
  }

  late final double _speed;
  late final double _game_width;
  late final String _color; // <-- HERE
  late final double _buffer; 
```
7. At this stage, we are ready to add in our paint buckets. Remember, the goal of the game will be to drag the correct paint drop color above the correct paint bucket. Let's start by creating our `PaintBucket` class. It's much simpler than our `PaintDrop` class because the buckets are stationary. For now, we don't even need an update function:
```
import 'package:flame/components.dart';

class PaintBucket extends SpriteComponent {
  PaintBucket({
    super.sprite,
    super.position,
    super.size,
    super.anchor,
  }){}
}
```
In `main.dart`, just under where we set the background image, instatiate new `PaintBucket` objects:
```
   // Add the static background image
    add(SpriteComponent(
        sprite: Sprite(background),
        size: Vector2(size.x, size.y),
        position: Vector2(0, 0)));
   
    //////////////// NEW BELOW ////////////////
    
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
```
We add 4 paint buckets for our 4 colors. We also position each bucket equidistance from each other across the screen using the `size` parameter provided by the game class. Lastly, we set the size and anchor positions.

## Adding collision logic (Workshop 5)
Now that our game looks prettier and we have basic dragging logic in place, we want to detect collisions between buckets and paint drops. Why? 2 reasons
- If a paint drop goes "into" a bucket, we want it to disappear!
- We want to keep track of whether paint drops going into the correct color paint bucket to give us a value to keep track of as the score for our game. 


## Resources
1. https://docs.flame-engine.org/1.6.0/tutorials/bare_flame_game.html
2. https://www.freepik.com/free-photos-vectors/artistic-background
3. https://medium.com/simform-engineering/basics-of-game-development-using-flame-bee1b8cf7320
4. https://medium.com/simform-engineering/build-collision-based-game-using-flame-in-flutter-ba1fc86702bd
5. https://github.com/flame-engine/flame/blob/main/examples/lib/stories/sprites/basic_sprite_example.dart
