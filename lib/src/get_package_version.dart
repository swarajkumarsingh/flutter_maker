import 'dart:io';

Future<String?> getPackageCurrentVersion() async {
  const command = 'dart';
  final args = <String>['pub', 'global', 'list'];

  final result = await Process.run(command, args);

  if (result.exitCode != 0) {
    print('Command failed with exit code ${result.exitCode}.');
    print('Command error:\n${result.stderr}');
    return null;
  }

  final output = result.stdout.toString();

  final error = result.stderr.toString();
  if (error.isNotEmpty) {
    print('Command error:\n$error');
    return null;
  }

  final regex = RegExp(r'flutter_maker (\d+\.\d+\.\d+)');
  final match = regex.firstMatch(output);
  return match?.group(1) ?? '';
}
