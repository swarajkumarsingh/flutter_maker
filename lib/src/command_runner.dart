// ignore_for_file: inference_failure_on_instance_creation, avoid_print

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:flutter_maker/src/commands/maker_command.dart';
import 'package:flutter_maker/src/commands/update_command.dart';
import 'package:flutter_maker/src/get_package_version.dart';
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
      final result = await getPackageCurrentVersion();
      print('\x1B[32m$result \x1B[0m');
      exitCode = ExitCode.success.code;
    } else {
      exitCode = await super.runCommand(topLevelResults);
    }
    await _checkForUpdates();
    return exitCode;
  }

  Future<void> _checkForUpdates() async {
    try {
      final latestVersion = await _pubUpdater.getLatestVersion(packageName);
      final latestPackageVersion = await getPackageCurrentVersion();
      final isUpToDate = latestPackageVersion == latestVersion;
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
