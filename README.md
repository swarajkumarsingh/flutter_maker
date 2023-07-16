# Flutter Maker | CLI

- Generate clean code folders and file programmatically with pure dart independent code

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
  flutter_maker:
```

2. Import the package and use it in your Flutter App.

```dart
import 'package:flutter_maker/flutter_maker.dart';
```

3. If the CLI application is available on [pub](https://pub.dev), activate globally via:

```sh
dart pub global activate flutter_maker
```

Or locally via:

```sh
dart pub global activate --source=path <path to this package>
dart pub global activate --source path .
```

## Example

Create files and folder
```
  maker make home
```
Get package version
```
  maker -v
```
Get Help
```
  maker -h
```

## Project Folder Structure
```
- bin
  - flutter_maker.dart
- lib
  - src
    - commands
      - commands.dart
      - maker_command.dart
      - update_command.dart
    - local
      - local_strings.dart
    - version.dart
    - commands_helper.dart
    - command_runner.dart.dart
    - string_extension.dart
  - flutter_maker.dart
```

## Programmatically Created Folder Structure

```
- feature
  - Home
    - data
      - Data_Source
      - Local
      - Repository
    - domain
      - Model
      - Repository
    - presentation
      - View
      - ViewModel
      - Widgets
```

## Contributions

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an issue. <br>
<br>
If you fixed a bug or implemented a feature, please send a pull request.
