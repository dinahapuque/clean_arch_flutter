import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Exception, List<ResultSearch>>> search(String searchText);
}
