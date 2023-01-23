# Paint Drop App for W&M Spring 2023 (GDSC)

A new Flutter project.

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
5. In the side project menu, delete the following directories: `macos`, `linux`, `windows`, and `test`.
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


## Resources
1. https://docs.flame-engine.org/1.6.0/tutorials/bare_flame_game.html
2. https://www.freepik.com/free-photos-vectors/artistic-background