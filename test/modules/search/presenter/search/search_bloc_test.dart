import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_arch/modules/search/presenter/search/states/state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText {}

main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test("deve retornar um SearchSuccess", () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));

    bloc.add("Diná");
  });

    test("deve retornar um SearchError", () {
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));
    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));

    bloc.add("Diná");
  });
}
