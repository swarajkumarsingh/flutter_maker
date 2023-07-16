// Copyright (c) 2023, Swaraj Kumar Singh
// https://github.com/swarajkumarsingh
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:args/command_runner.dart';
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
    final featureName = argResults!.arguments.first;
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
      _logger.alert('Creating Feature folder');
      rootFeatureDir.createSync();
    }

    // create featureName(home)
    final featureNameDir = Directory('${libFolder.path}/feature/$featureName');
    if (!featureNameDir.existsSync()) {
      _logger.alert('Creating ${featureName.capitalize} folder');
      featureNameDir.createSync();
    }

    // create folder (data, domain, presentation) layer
    ///* create data folder
    final dataDir = Directory('${libFolder.path}/feature/$featureName/data');
    if (!dataDir.existsSync()) {
      _logger.alert('Creating Data folder');
      dataDir.createSync();
    }

    ///* create domain folder
    final domainDir =
        Directory('${libFolder.path}/feature/$featureName/domain');
    if (!domainDir.existsSync()) {
      _logger.alert('Creating Domain folder');
      domainDir.createSync();
    }

    ///* create presentation folder
    final presentationDir =
        Directory('${libFolder.path}/feature/$featureName/presentation');
    if (!presentationDir.existsSync()) {
      _logger.alert('Creating Presentation folder');
      presentationDir.createSync();
    }

    if (fileless) {
      _logger.success('$featureName Dir created successfully');
      return ExitCode.success.code;
    }

    // Now create files and write boilerplate code
    _logger.success(
      '${featureName.capitalize} Dir with files created successfully',
    );
    return ExitCode.success.code;
  }
}
