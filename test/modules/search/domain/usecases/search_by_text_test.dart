import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  // se utiliza o método call, não precisa invocá-lo como usecase.call();
  test('deve retornar uma lista de ResultSearch', () async {

    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    final result = await usecase("Diná");

    expect(result | null, isA<List<ResultSearch>>()); // result | null == result.getOrElse(() => null)
  });

  test('deve retornar um InvalidTextError caso o texto seja inválido', () async {

    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    var result = await usecase(null);

    // expect(result.isLeft(), true); // result | null, null
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase("");

    expect(result.fold(id, id), isA<InvalidTextError>());

  });
}
