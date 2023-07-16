import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:flutter_maker/src/commands/maker_command.dart';
import 'package:flutter_maker/src/commands/update_command.dart';
import 'package:flutter_maker/src/version.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

const executableName = 'flutter_maker';
const packageName = 'flutter_maker';
const description = 'Run flutter scripts from pubspec.yaml';

class FlutterMakerCommandRunner extends CommandRunner<int> {
  FlutterMakerCommandRunner({
    Logger? logger,
    PubUpdater? pubUpdater,
  })  : _logger = logger ?? Logger(),
        _pubUpdater = pubUpdater ?? PubUpdater(),
        super(executableName, description) {
    argParser.addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Print the current version.',
    );

    addCommand(MakerCommand(logger: _logger));
    addCommand(UpdateCommand(logger: _logger, pubUpdater: _pubUpdater));
  }

  final Logger _logger;
  final PubUpdater _pubUpdater;

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final topLevelResults = parse(args);
      return await runCommand(topLevelResults) ?? ExitCode.success.code;
    } on FormatException catch (e, stackTrace) {
      _logger
        ..err(e.message)
        ..err('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(e.usage);
      return ExitCode.usage.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    final int? exitCode;
    if (topLevelResults['version'] == true) {
      _logger.info(getPackageVersion());
      exitCode = ExitCode.success.code;
    } else {
      exitCode = await super.runCommand(topLevelResults);
    }
    await _checkForUpdates();
    return exitCode;
  }

  String getPackageVersion() {
    Process.run('dart', ['pub', 'run', 'build_runner', 'build'])
        .then((ProcessResult result) {
      return packageVersion;
    });

    return packageVersion;
  }

  Future<void> _checkForUpdates() async {
    try {
      final latestVersion = await _pubUpdater.getLatestVersion(packageName);
      final isUpToDate = packageVersion == latestVersion;
      if (!isUpToDate) {
        _logger
          ..info('')
          ..info(
            '''
${lightYellow.wrap('Update available!')} ${lightCyan.wrap(packageVersion)} \u2192 ${lightCyan.wrap(latestVersion)}
Run ${lightCyan.wrap('dart pub global activate $packageName')} to update''',
          );
      }
    } catch (_) {}
  }
}
