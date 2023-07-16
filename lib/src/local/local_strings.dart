import 'package:flutter_maker/src/string_extension.dart';

final localString = _LocalString();

class _LocalString {
  String getDataSourceString(String featureName) {
    return '''
final ${featureName.lower}DataSource = _${featureName.capitalize}DataSource();
class _${featureName.capitalize}DataSource {     }
''';
  }

  String getLocalDataString(String featureName) {
    return 'class ${featureName.capitalize}DataProvider { }';
  }

  String getDataRepository(String featureName) {
    return '''
final ${featureName.capitalize}Repository ${featureName.lower}Repository = ${featureName.capitalize}RepositoryImpl(${featureName.lower}DataSource);
abstract class ${featureName.capitalize}Repository {}
     ''';
  }
}
