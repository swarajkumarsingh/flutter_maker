// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';

import 'package:flutter_maker/src/local/local_strings.dart';
import 'package:mason_logger/mason_logger.dart';

final commandHelper = _CommandHelper();

final currentDir = Directory.current;
final libFolder = Directory('${currentDir.path}/lib');

class _CommandHelper {
  bool _createFile(String path, String? content) {
    final file = File(path);
    try {
      file.writeAsStringSync(content ?? '');
      return true;
    } catch (e) {
      Logger().err(e.toString());
      return false;
    }
  }

  bool _createFolder(Directory path, String? folderName) {
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
      _createFolder(rootFeatureDir, 'feature');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createFeatureNameFolder(String featureName) {
    try {
      final featureNameDir =
          Directory('${libFolder.path}/feature/$featureName');
      _createFolder(featureNameDir, featureName);
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createDataFolder(String featureName) {
    try {
      final dataDir = Directory('${libFolder.path}/feature/$featureName/data');
      _createFolder(dataDir, 'data');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createDataSourceFolder(String featureName) {
    try {
      final dataSourceDir = Directory(
        '${libFolder.path}/feature/$featureName/data/data_source',
      );
      _createFolder(dataSourceDir, 'data_source');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createLocalFolder(String featureName) {
    try {
      final localDir =
          Directory('${libFolder.path}/feature/$featureName/data/local');
      _createFolder(localDir, 'local');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createDataRepositoryFolder(String featureName) {
    try {
      final dataRepositoryDir =
          Directory('${libFolder.path}/feature/$featureName/data/repository');
      _createFolder(dataRepositoryDir, 'repository');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createDomainFolder(String featureName) {
    try {
      final domainDir =
          Directory('${libFolder.path}/feature/$featureName/domain');
      _createFolder(domainDir, 'domain');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createModelFolder(String featureName) {
    try {
      final modelDir =
          Directory('${libFolder.path}/feature/$featureName/domain/model');
      _createFolder(modelDir, 'model');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createDomainRepositoryFolder(String featureName) {
    try {
      final domainRepositoryDir =
          Directory('${libFolder.path}/feature/$featureName/domain/repository');
      _createFolder(domainRepositoryDir, 'repository');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createPresentationFolder(String featureName) {
    try {
      final presentationDir =
          Directory('${libFolder.path}/feature/$featureName/presentation');
      _createFolder(presentationDir, 'presentation');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createViewFolder(String featureName) {
    try {
      final viewDir =
          Directory('${libFolder.path}/feature/$featureName/presentation/view');
      _createFolder(viewDir, 'view');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createViewModelFolder(String featureName) {
    try {
      final viewModelDir = Directory(
        '${libFolder.path}/feature/$featureName/presentation/view_model',
      );
      _createFolder(viewModelDir, 'view_model');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createWidgetsFolder(String featureName) {
    try {
      final widgetsDir = Directory(
        '${libFolder.path}/feature/$featureName/presentation/widgets',
      );
      _createFolder(widgetsDir, 'widgets');
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  // --------------------------------------------------

  int createLocalFile(bool fileless, String featureName) {
    try {
      if (!fileless) {
        _createFile(
          '${libFolder.path}/feature/$featureName/data/local/${featureName}_data_provider.dart',
          localString.getLocalDataString(featureName),
        );
      }
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createDataSourceFile(bool fileless, String featureName) {
    try {
      if (!fileless) {
        _createFile(
          '${libFolder.path}/feature/$featureName/data/data_source/${featureName}_data_source.dart',
          localString.getDataSourceString(featureName),
        );
      }
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createDomainRepositoryFile(bool fileless, String featureName) {
    try {
      if (!fileless) {
        _createFile(
          '${libFolder.path}/feature/$featureName/domain/repository/${featureName}_repository_impl.dart',
          localString.getDomainRepositoryString(featureName),
        );
      }
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createDataRepositoryFile(bool fileless, String featureName) {
    try {
      if (!fileless) {
        _createFile(
          '${libFolder.path}/feature/$featureName/data/repository/${featureName}_repository.dart',
          localString.getDataRepositoryString(featureName),
        );
      }
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }

  int createModelFile(bool fileless, String featureName) {
    try {
      if (!fileless) {
        _createFile(
          '${libFolder.path}/feature/$featureName/domain/model/$featureName.dart',
          '',
        );
      }
      return ExitCode.success.code;
    } catch (e) {
      return ExitCode.software.code;
    }
  }
}
