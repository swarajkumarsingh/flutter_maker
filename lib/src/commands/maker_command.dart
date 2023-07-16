// Copyright (c) 2023, Swaraj Kumar Singh
// https://github.com/swarajkumarsingh
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: cascade_invocations, lines_longer_than_80_chars

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:flutter_maker/src/commands_helper.dart';
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
    var featureName = '';
    final fileless = argResults!.wasParsed('fileless');

    try {
      featureName = argResults!.arguments.first.lower;
    } catch (e) {
      _logger.err(
        'Error: Invalid make value entered, try correcting the value or re-enter the value',
      );
      return ExitCode.software.code;
    }
    final updateCheckProgress = _logger.progress('Started Building');

    if (featureName.isEmpty) {
      _logger.err('Error: Invalid feature name');
      return ExitCode.software.code;
    }

    // Check is lib folder is present
    final currentDir = Directory.current;
    final libFolder = Directory('${currentDir.path}/lib');
    if (!libFolder.existsSync()) {
      _logger.err('lib folder not found in the root directory');
      return ExitCode.software.code;
    }

    //! create feature folder
    commandHelper.createFeatureFolder();

    //! create featureName(home) folder
    commandHelper.createFeatureNameFolder(featureName);

    //! create data folder
    commandHelper.createDataFolder(featureName);

    //! create data_source folder
    commandHelper.createDataSourceFolder(featureName);

    //? create data_source file
    commandHelper.createDataSourceFile(fileless, featureName);

    //! create local folder
    commandHelper.createLocalFolder(featureName);

    //? create data_provider file
    commandHelper.createLocalFile(fileless, featureName);

    //! create data Repository folder
    commandHelper.createDataRepositoryFolder(featureName);

    //? create repository file
    commandHelper.createDataRepositoryFile(fileless, featureName);

    //! create domain folder
    commandHelper.createDomainFolder(featureName);

    //! create model folder
    commandHelper.createModelFolder(featureName);

    //? create model file
    commandHelper.createModelFile(fileless, featureName);

    //! create Domain Repository folder
    commandHelper.createDomainRepositoryFolder(featureName);

    //? create repository file
    commandHelper.createDomainRepositoryFile(fileless, featureName);

    //! create presentation folder
    commandHelper.createPresentationFolder(featureName);

    //! create view folder
    commandHelper.createViewFolder(featureName);

    //! create View-Model folder
    commandHelper.createViewModelFolder(featureName);

    //! create Widgets folder
    commandHelper.createWidgetsFolder(featureName);

    // Now create files and write boilerplate code
    _logger.success(
      '${featureName.capitalize} Directory with files created successfully',
    );

    updateCheckProgress.complete('Complete Building');
    return ExitCode.success.code;
  }
}
