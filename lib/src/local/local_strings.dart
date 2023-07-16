import 'package:flutter_maker/src/string_extension.dart';

final localString = _LocalString();

class _LocalString {
  String getDataSourceString(String featureName) {
    return '''
class ${featureName.capitalize}DataSource {     }
''';
  }

  String getLocalDataString(String featureName) {
    return 'class ${featureName.capitalize}DataProvider { }';
  }

  String getDataRepositoryString(String featureName) {
    return '''
final ${featureName.capitalize}Repository ${featureName.lower}Repository = ${featureName.capitalize}RepositoryImpl(${featureName.capitalize}DataSource());
abstract class ${featureName.capitalize}Repository {}
     ''';
  }

  String getDomainRepositoryString(String featureName) {
    return '''
final ${featureName}RepositoryImpl = ${featureName.capitalize}RepositoryImpl(${featureName.capitalize}DataSource());

class ${featureName.capitalize}RepositoryImpl extends ${featureName.capitalize}Repository {
${featureName.capitalize}RepositoryImpl(this._${featureName.lower}DataSource);
final ${featureName.capitalize}DataSource _${featureName.lower}DataSource;
  }
     ''';
  }
}
