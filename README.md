# Paint Drop App for W&M Spring 2023 (GDSC)

Flutter game app to demonstrate game design and app development basics.

The presentation that accompanies this repository is [here](https://docs.google.com/presentation/d/164_ThDXfw_-uM7lYJTq7KEzJL6aox_4M/edit?usp=sharing&ouid=105181047619494018000&rtpof=true&sd=true).

## Prerequisites
1. Install a code editor like [Android Studio](https://developer.android.com/studio?gclid=CjwKCAiA2rOeBhAsEiwA2Pl7Q12WSa4Wl206GuOh9YzMBcimmrDEISP9rX89B50LeVaQ0pRYUO6TkRoCe3EQAvD_BwE&gclsrc=aw.ds) or [VS Code](https://code.visualstudio.com/download).
2. Install Flutter using [this](https://docs.flutter.dev/get-started/install?gclid=CjwKCAiA2rOeBhAsEiwA2Pl7Q_iIJ4SSU8DQrpevxX2g4hXcDft6TKVtt3ydtIwAqI1gckdWDbp-zhoCKU0QAvD_BwE&gclsrc=aw.ds) guide.
3. Open terminal. Run `flutter doctor` to make sure everything is working as expected. Make sure you have green checkmarks by Flutter, Android toolchain, Chrome, and VS Code/Android Studio. If you want to run your app using iOS, also make sure you have a green checkmark next to Xcode.
4. Follow the instructions in the guide from step 2 to set up emulators/devices for Android, iOS, and/or Chrome.
Note: The first time you run your app on an iOS device, you need to do it through Xcode by right-clicking `ios` from the sidebar and selecting `Flutter/Open iOS module in Xcode`. Afterwards, you can run your app from Android Studio like normal.
   
## Creating your first app
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

## Flame game engine basics
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
class MyGame extends FlameGame with HasDraggableComponents {
  @override
  Color backgroundColor() => const Color(0xFF003366);
}
```
All we have added to the game so far is a background color instead of the default transparent background. Run your app, and you should have a dark blue background. Play around with changing the background color. Save your code and thanks to hot-reload, the new background color should render automatically.
9. Navigate to the `lib` folder in the left menu (or via Terminal) and create a new file called `star.dart`.
10. At the top import the following: 
```
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
```
These are the necessary `flame` and math packages we need to create the stars that will fall from the sky and be draggable.
7. Next create a `Star` class that extends PositionComponent, which is a Flame game component with attributes for `position`, `size`, `scale`, `angle`, and `anchor`. We will instantiate the Star class as follows:
```

```


## Resources
1. https://docs.flame-engine.org/1.6.0/tutorials/bare_flame_game.html
2. https://www.freepik.com/free-photos-vectors/artistic-background
3. https://medium.com/simform-engineering/basics-of-game-development-using-flame-bee1b8cf7320
4. https://medium.com/simform-engineering/build-collision-based-game-using-flame-in-flutter-ba1fc86702bd
