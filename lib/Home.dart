import 'Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagem() async {
    http.Response response = await http.get(_urlBase + "/posts");
    var dadosJson = json.decode(response.body);

    List<Post> postagens = [];

    for (var post in dadosJson) {
      print("post: " + post["title"]);
      Post p = Post(post["userId"], post["body"], post["id"], post["title"]);
      postagens.add(p);
    }
    return postagens;
  }

  _post() async {
    Post post = new Post(120, "postagen", 0, "titulo");

    var corpo = json.encode(post.toJson());

    http.Response response = await http.post(
      _urlBase + "/posts",
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: corpo,
    );

    print("response: ${response.statusCode}");
    print("response: ${response.body}");
  }

  _put() async {
    Post post = new Post(120, "postagen", 0, "titulo");

    var corpo = json.encode(post.toJson());
    http.Response response = await http.put(
      _urlBase + "/posts/2",
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: corpo,
    );

    print("response: ${response.statusCode}");
    print("response: ${response.body}");
  }

  _patch() async {
    Post post = new Post(120, "postagen", 0, "titulo");

    var corpo = json.encode(post.toJson());
    http.Response response = await http.patch(
      _urlBase + "/posts/2",
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: corpo,
    );

    print("response: ${response.statusCode}");
    print("response: ${response.body}");
  }

  _delete() async {
    http.Response response = await http.delete(_urlBase + "/posts/1");

    if (response.statusCode == 200) {
    } else {
      AlertDialog(
        title: Text("Erro ao deletar"),
        titlePadding: EdgeInsets.all(20),
        titleTextStyle: TextStyle(fontSize: 20, color: Colors.orange),
        content: Text("Erro desconhecido"),
        actions: <Widget>[
          FloatingActionButton(
              onPressed: () {
                print(" esta tudo ok ");
                Navigator.pop(context);
              },
              child: Text("OK")),
        ],
      );
    }

    print("response: ${response.statusCode}");
    print("response: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 162, 255),
                        elevation: 15,
                        shadowColor: Color.fromARGB(255, 65, 66, 65)),
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    onPressed: _post),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 162, 255),
                        elevation: 15,
                        shadowColor: Color.fromARGB(255, 65, 66, 65)),
                    child: Text(
                      "Atualizar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    onPressed: _patch),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 162, 255),
                        elevation: 15,
                        shadowColor: Color.fromARGB(255, 65, 66, 65)),
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    onPressed: _delete),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPostagem(),
                builder: ((context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      break;
                    case ConnectionState.active:
                      break;

                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print("Erro ao carregar a lista");
                        return AlertDialog(
                          title: Text("Sem conexão com a internet"),
                          titlePadding: EdgeInsets.all(20),
                          titleTextStyle:
                              TextStyle(fontSize: 20, color: Colors.orange),
                          content: Text("Verifique sua conexão"),
                          actions: <Widget>[
                            FloatingActionButton(
                                onPressed: () {
                                  print("selecionado ");
                                  Navigator.pop(context);
                                },
                                child: Text("OK")),
                          ],
                        );
                      } else {
                        print("Lista carregou!!");
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              List<Post>? lista = snapshot.data;
                              Post post = lista![index];
                              return ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.id.toString()),
                              );
                            });
                      }
                      break;
                  }
                  return AlertDialog(
                    title: Text("Erro ao carregar"),
                    titlePadding: EdgeInsets.all(20),
                    titleTextStyle:
                        TextStyle(fontSize: 20, color: Colors.orange),
                    content: Text("Erro future"),
                    actions: <Widget>[
                      FloatingActionButton(
                          onPressed: () {
                            print(" esta tudo ok ");
                            Navigator.pop(context);
                          },
                          child: Text("OK")),
                    ],
                  );
                  ;
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
