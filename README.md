# Flutter Url Launcher Plus

- flutter_cli helps to install package from cmd.

## Supported Devices

- Android
- IOS
- Web
- Linux
- Windows
- Macos

## Installation

1. Add the latest version of package to your pubspec.yaml (and run`dart pub get`):

```yaml
dependencies:
  flutter_cli:
```

2. Import the package and use it in your Flutter App.

```dart
import 'package:flutter_cli/flutter_cli.dart';
```
3. If the CLI application is available on [pub](https://pub.dev), activate globally via:

```sh
dart pub global activate flutter_scripts
```

Or locally via:

```sh
dart pub global activate --source=path <path to this package>
```

## Example

```
  flutter_cli install dio
```


## Contributions

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an issue. <br>
<br>
If you fixed a bug or implemented a feature, please send a pull request.
