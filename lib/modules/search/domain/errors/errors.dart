abstract class FailureSearch implements Exception {}

class InvalidTextError implements FailureSearch {}

// poderia estar em um arquivo de erros na pasta de infra
class DatasourceError implements FailureSearch {
  final String message;

  DatasourceError({this.message});
}
