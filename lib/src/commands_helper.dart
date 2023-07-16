import 'dart:io';

import 'package:mason_logger/mason_logger.dart';

final commandHelper = _CommandHelper();

final currentDir = Directory.current;
final libFolder = Directory('${currentDir.path}/lib');

class _CommandHelper {
  bool createFile(String path, String? content) {
    final file = File(path);
    try {
      file.writeAsStringSync(content ?? '');
      return true;
    } catch (e) {
      Logger().err(e.toString());
      return false;
    }
  }

  bool createFolder(Directory path, String? folderName) {
    try {
      if (!path.existsSync()) {
        Logger().info(lightYellow.wrap('Creating ${folderName ?? ""} folder'));
        path.createSync();
      }
    } catch (e) {}
    return false;
  }

  int createFeatureFolder() {
    try {
      final rootFeatureDir = Directory('${libFolder.path}/feature');
      createFolder(rootFeatureDir, 'feature');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }
}
