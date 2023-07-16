// Copyright (c) 2023, Swaraj Kumar Singh
// https://github.com/swarajkumarsingh
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:flutter_maker/src/local/local_strings.dart';
import 'package:flutter_maker/src/string_extension.dart';
import 'package:mason_logger/mason_logger.dart';

class MakerCommand extends Command<int> {
  MakerCommand({
    Logger? logger,
  }) : _logger = logger ?? Logger() {
    argParser.addFlag('fileless');
  }

  final Logger _logger;

  @override
  String get name => 'make';

  @override
  String get description => 'Programmatically Make folder and file';

  @override
  Future<int> run() async {
    final featureName = argResults!.arguments.first.lower;
    final fileless = argResults!.wasParsed('fileless');
    _logger.progress('Started Building');

    if (featureName.isEmpty) {
      _logger.err('invalid feature name');
      return ExitCode.software.code;
    }

    // Check is lib folder is present
    final currentDir = Directory.current;
    final libFolder = Directory('${currentDir.path}/lib');
    if (!libFolder.existsSync()) {
      _logger.err('lib folder not found in the root directory');
      return ExitCode.software.code;
    }

    // create feature's folder
    final rootFeatureDir = Directory('${libFolder.path}/feature');
    if (!rootFeatureDir.existsSync()) {
      _logger.info(lightYellow.wrap('Creating Feature folder'));
      rootFeatureDir.createSync();
    }

    // create featureName(home)
    final featureNameDir = Directory('${libFolder.path}/feature/$featureName');
    createFolder(featureNameDir, featureName);

    ///* create data folder
    final dataDir = Directory('${libFolder.path}/feature/$featureName/data');
    createFolder(dataDir, 'data');

    // Data Source
    final dataSourceDir = Directory(
      '${libFolder.path}/feature/$featureName/data/data_source',
    );
    createFolder(dataSourceDir, 'data_source');
    if (!fileless) {
      createFile(
        '${libFolder.path}/feature/$featureName/data/data_source/${featureName}_data_source.dart',
        localString.getDataSourceString(featureName),
      );
    }

    // Local
    final localDir =
        Directory('${libFolder.path}/feature/$featureName/data/local');
    createFolder(localDir, 'local');
    if (!fileless) {
      createFile(
        '${libFolder.path}/feature/$featureName/data/local/${featureName}_data_provider.dart',
        localString.getLocalDataString(featureName),
      );
    }

    // Repository
    final dataRepositoryDir =
        Directory('${libFolder.path}/feature/$featureName/data/repository');
    createFolder(dataRepositoryDir, 'repository');
    if (!fileless) {
      createFile(
        '${libFolder.path}/feature/$featureName/data/repository/${featureName}_repository.dart',
        localString.getDataRepositoryString(featureName),
      );
    }

    ///* create domain folder
    final domainDir =
        Directory('${libFolder.path}/feature/$featureName/domain');
    createFolder(domainDir, 'domain');

    // Model
    final modelDir =
        Directory('${libFolder.path}/feature/$featureName/domain/model');
    createFolder(modelDir, 'model');
    if (!fileless) {
      createFile(
        '${libFolder.path}/feature/$featureName/domain/model/$featureName.dart',
        '',
      );
    }

    // Repository
    final domainRepositoryDir =
        Directory('${libFolder.path}/feature/$featureName/domain/repository');
    createFolder(domainRepositoryDir, 'repository');
    if (!fileless) {
      createFile(
        '${libFolder.path}/feature/$featureName/domain/repository/${featureName}_repository_impl.dart',
        localString.getDomainRepositoryString(featureName),
      );
    }

    ///* create presentation folder
    final presentationDir =
        Directory('${libFolder.path}/feature/$featureName/presentation');
    createFolder(presentationDir, 'presentation');

    // view
    final viewDir =
        Directory('${libFolder.path}/feature/$featureName/presentation/view');
    createFolder(viewDir, 'view');

    // View Model
    final viewModelDir = Directory(
      '${libFolder.path}/feature/$featureName/presentation/view_model',
    );
    createFolder(viewModelDir, 'view_model');

    // Widgets
    final widgetsDir = Directory(
      '${libFolder.path}/feature/$featureName/presentation/widgets',
    );
    createFolder(widgetsDir, 'widgets');

    // Now create files and write boilerplate code
    _logger.success(
      '${featureName.capitalize} Dir with files created successfully',
    );
    return ExitCode.success.code;
  }
}

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
