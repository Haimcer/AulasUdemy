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
  var player = AudioPlayer();
  bool primeiraExecucao = true;
  double volume = 0.5;

  _executar() async {
    player.setVolume(volume);
    if (primeiraExecucao) {
      await player.play(AssetSource('audios/musica.mp3'));
      primeiraExecucao = false;
    } else {
      player.resume();
    }
  }

  _pausar() async {
    await player.pause();
  }

  _parar() async {
    await player.stop();
  }

  @override
  Widget build(BuildContext context) {
    _executar();

    return Scaffold(
      appBar: AppBar(
        title: Text("Executando sons"),
      ),
      body: Column(
        children: <Widget>[
          Slider(
              value: volume,
              min: 0,
              max: 1,
              divisions: 10,
              onChanged: (novoVolume) {
                setState(() {
                  volume = novoVolume;
                });
                player.setVolume(novoVolume);
              }),
          //Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/executar.png"),
                  onTap: () {
                    _executar();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/pausar.png"),
                  onTap: () {
                    _pausar();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/parar.png"),
                  onTap: () {
                    _parar();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
