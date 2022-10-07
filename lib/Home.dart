import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCampo = TextEditingController();

  _Salvar() {}
  _Recuperar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manipulação de dados"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(children: <Widget>[
          Text(""),
          TextField(
            decoration: InputDecoration(
              labelText: 'Digite algo',
            ),
            controller: _controllerCampo,
          ),
          Row(
            children: <Widget>[
              TextButton(
                onPressed: _Salvar,
                child: Text(
                  "Salvar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blue)),
              ),
              Container(
                padding: EdgeInsets.all(7),
              ),
              TextButton(
                onPressed: _Recuperar,
                child: Text(
                  "Ler",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blue)),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
