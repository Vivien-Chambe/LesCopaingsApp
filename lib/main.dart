// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'roulette.dart';
import 'drunk_pirate.dart';
import 'NIHE.dart';
import 'undercover.dart';
import 'pmu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Les copaings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 17, 63, 187)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Les copaings'),
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
  void _goToDrunkPirate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DrunkPirate()),
    );
  }

  void _goToNIHE() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NIHE()),
    );
  }

  void _goToUndercover() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Undercover()),
    );
  }

  void _goToBottle() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Bottle()),
    );
  }

  void _goToPMU() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PMU()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: const Color.fromARGB(255, 190, 190, 170),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.emoji_emotions),
                    title: Text('Drunk Pirate'),
                    subtitle: Text(''),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      TextButton(
                        onPressed: _goToDrunkPirate,
                        child: const Text('Jouer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 190, 190, 170),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.emoji_emotions),
                    title: Text('Je n\'ai jamais'),
                    subtitle: Text('Répondez à des questions'),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      TextButton(
                        onPressed: _goToNIHE,
                        child: const Text('Jouer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 190, 190, 170),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.emoji_emotions),
                    title: Text('Undercover'),
                    subtitle: Text("Trouvez qui est l'imposteur !"),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      TextButton(
                        onPressed: _goToUndercover,
                        child: const Text('Jouer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 190, 190, 170),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.emoji_emotions),
                    title: Text('Bouteille à la mer'),
                    subtitle: Text("Roue décisionnelle"),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      TextButton(
                        onPressed: _goToBottle,
                        child: const Text('Jouer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 190, 190, 170),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.emoji_emotions),
                    title: Text('PMU'),
                    subtitle: Text("Pariez sur les chevaux"),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      TextButton(
                        onPressed: _goToPMU,
                        child: const Text('Jouer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
