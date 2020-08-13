import 'dart:convert';

import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_arch/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// os testes devem ser offline para não sobrecarregar
class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);

  test("deve retornar uma lista de ResultSearchModel", () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(data: jsonDecode(githubResponse), statusCode: 200));

    // não precisa do await
    final future = datasource.getSearch("searchText");
    expect(future, completes);
  });

  test("deve retornar um DatasourceError se o código não for 200", () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    // não precisa do await
    final future = datasource.getSearch("searchText");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  // não necessário
  // test("deve retornar um Exception se tiver um erro no dio", () async {
  //   when(dio.get(any)).thenThrow(Exception());

  //   // não precisa do await
  //   final future = datasource.getSearch("searchText");
  //   expect(future, throwsA(isA<Exception>()));
  // });
}
