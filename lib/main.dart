import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final player = AudioPlayer();

  _executar() async {
    await player.play(AssetSource('audios/musica.mp3'));

    /*
    String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3";
    int resultado = await audioPlayer.play(url);

    if( resultado == 1 ){
      //sucesso
    }*/
  }

  @override
  Widget build(BuildContext context) {
    _executar();

    return Container();
  }
}
