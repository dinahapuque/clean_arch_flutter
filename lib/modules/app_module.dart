import 'package:clean_arch/modules/app_widget.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_arch/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:clean_arch/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_arch/modules/search/presenter/search/search_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchBloc(i())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, __) => SearchPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
