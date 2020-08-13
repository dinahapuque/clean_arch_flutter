import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

// depender de uma abstração é melhor do que de uma implementação, princ na questão de injeçõa de dependencia
abstract class SearchByText {
  Future<Either<Exception, List<ResultSearch>>> call(
      String searchText); // ou uma exception ou uma future
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<Exception, List<ResultSearch>>> call(String searchText) async {
    if (searchText == null || searchText.isEmpty)
      return Left(InvalidTextError());

    return repository.search(searchText);
  }
}
