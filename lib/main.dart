import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(
      home: homePage(),
    ));

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";

      db.execute(sql);
    });
    return bd;
    //print("aberto: " + retorno.isOpen.toString());
  }

  _salvar() async {
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {"nome": "Maria Silva", "idade": 58};
    int id = await bd.insert("usuarios", dadosUsuario);
  }

  _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();
    String sql = "SELECT * FROM usuarios";
    List usuarios = await bd.rawQuery(sql);

    for (var usuario in usuarios) {}
  }

  _recuperarUsuario(int id) async {
    Database bd = await _recuperarBancoDados();
    List usuarios = await bd.query("usuarios",
        columns: ["id", "nome", "idade"],
        where: "id = ?",
        whereArgs: [id, "Jamilton Damasceno"]);
    for (var usuario in usuarios) {}
  }

  excluirUsuario(int id) async {
    Database bd = await _recuperarBancoDados();
    int retorno = await bd.delete("usuarios", where: "id = ?", whereArgs: [id]);
  }

  atualizarUsuario(int id) async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {"nome": "Maria Silva", "idade": 58};

    int retorno = await bd.update("usuarios", dadosUsuario, whereArgs: [id]);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
