import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _itens = [];

  void _carregarItens() {
    for (int i = 0; i <= 10; i++) {
      Map<String, dynamic> item = Map();
      item["titulo"] = "Título ${i} Allan";
      item["subtitulo"] = "descrição ${i} Ribeiro";
      _itens.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    _carregarItens();
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, indice) {
              //Map<String, dynamic> item = _itens[indice];
              //print("item${item["Título"]}");
              return ListTile(
                //onLongPress: () {

                //},
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(_itens[indice]["titulo"]),
                          titlePadding: EdgeInsets.all(20),
                          titleTextStyle:
                              TextStyle(fontSize: 20, color: Colors.orange),
                          content: Text(_itens[indice]["subtitulo"]),
                          actions: <Widget>[
                            FloatingActionButton(
                                onPressed: () {
                                  print("selecionado sim");
                                },
                                child: Text("sim")),
                            FloatingActionButton(
                                onPressed: () {
                                  print("selecionado não");
                                },
                                child: Text("Não")),
                          ],
                        );
                      });
                },
                title: Text(_itens[indice]["titulo"]),
                subtitle: Text(_itens[indice]["subtitulo"]),
              );
            },
          )),
    );
  }
}
