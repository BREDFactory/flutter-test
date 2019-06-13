# flutter_github_jobs

<img src="https://sd-cdn.fr/wp-content/uploads/2018/02/flutter-bandeau-770x311.jpg" alt="flutter" width="200"/>

A Flutter project about [GitHub Jobs API](https://jobs.github.com/).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Installation

- Clone the project `git clone https://github.com/BREDFactory/flutter-test.git`   
- Install the dependencies `cd flutter-test && flutter pub get`
- Run your application on IOS or Android: run `flutter emulators ` to see all your available emulators   
- Then run `flutter emulators --launch <emulator id>` to lauch your emulator   
- Finally run `flutter run` to lauch your application

## Desktop

To use the desktop version of this app you need to be on the flutter master channel.

To switch to the master channel run the following commands:
```
flutter channel master
flutter upgrade
```
You also need to set the ENABLE_FLUTTER_DESKTOP environment variable to true.
```
export ENABLE_FLUTTER_DESKTOP=true
```
Then to verify that it works run `flutter devices` and make sure your device is listed.