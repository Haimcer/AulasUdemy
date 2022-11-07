import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _imagem;

  Future _recuperarImagem(bool daCamera) async {
    XFile? imagemSelecionada;
    if (daCamera) {
      //camera
      imagemSelecionada =
          await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      //galeria
      imagemSelecionada =
          await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = File(imagemSelecionada!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar imagem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FloatingActionButton(
              child: Text("Camera"),
              onPressed: () {
                _recuperarImagem(true);
              },
            ),
            FloatingActionButton(
              child: Text("Galeria"),
              onPressed: () {
                _recuperarImagem(false);
              },
            ),
            _imagem == null ? Container() : Image.file(_imagem!)
          ],
        ),
      ),
    );
  }
}
