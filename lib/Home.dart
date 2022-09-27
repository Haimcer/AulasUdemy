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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado"),
      ),
      body: FutureBuilder<List<Post>>(
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
                print("Lista erro ao carregar");
                return AlertDialog(
                  title: Text("Erro ao carregar"),
                  titlePadding: EdgeInsets.all(20),
                  titleTextStyle: TextStyle(fontSize: 20, color: Colors.orange),
                  content: Text("Fudeu"),
                  actions: <Widget>[
                    FloatingActionButton(
                        onPressed: () {
                          print("selecionado sim");
                          Navigator.pop(context);
                        },
                        child: Text("sim")),
                    FloatingActionButton(
                        onPressed: () {
                          print("selecionado não");
                          Navigator.pop(context);
                        },
                        child: Text("Não")),
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
            title: Text("titulo"),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: TextStyle(fontSize: 20, color: Colors.orange),
            content: Text("erro no build"),
          );
          ;
        }),
      ),
    );
  }
}
