import 'package:clean_arch/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_arch/modules/search/presenter/search/states/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Type something...",
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: bloc,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is SearchStart) {
                    return Center(
                      child: Text('Digite um texto para começar'),
                    );
                  }

                  if (state is SearchError) {
                    // posso testar os tipos de erro aqui dentro
                    return Center(
                      child: Text('Houve um erros'),
                    );
                  }

                  if (state is SearchLoading) {
                    // posso testar os tipos de erro aqui dentro
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final list = (state as SearchSuccess).list;

                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, id) {
                        final item = list[id];
                        return ListTile(
                          leading: item.avatarUrl == null
                              ? Container()
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(item.avatarUrl),
                                ),
                          title: Text(item.login ?? ""),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
