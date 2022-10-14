import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Widgets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _listaNomes = ['Allan', 'Valdemir', 'Nair', 'Tobias'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _listaNomes.length,
            itemBuilder: (context, index) {
              final item = _listaNomes[index];
              return Dismissible(
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        )
                      ]),
                ),
                secondaryBackground: Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        )
                      ]),
                ),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                  } else if (direction == DismissDirection.startToEnd) {}
                  setState(() {
                    _listaNomes.removeAt(index);
                  });
                },
                key: Key(item),
                child: ListTile(
                  title: Text(_listaNomes[index] ?? 0),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
