// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:tuple/tuple.dart';
import 'package:sensors/sensors.dart';

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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 17, 63, 187)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Les Copaings'),
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
  double liquidX = 0.0;
  double liquidY = 0.0;
  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        liquidX = event.x;
        liquidY = event.y;
      });
    });
  }

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
              color: Color.fromARGB(255, 190, 190, 170),
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
              color: Color.fromARGB(255, 190, 190, 170),
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
              color: Color.fromARGB(255, 190, 190, 170),
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
          ],
        ),
      ),
    );
  }
}

class DrunkPirate extends StatefulWidget {
  const DrunkPirate({super.key});

  @override
  State<DrunkPirate> createState() => _DrunkPirateState();
}

class _DrunkPirateState extends State<DrunkPirate> {
  var _random = Random().nextInt(274).toString();
  void _changeImage() {
    setState(() {
      _random = Random().nextInt(274).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return newMethod();
  }

  Scaffold newMethod() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Drunk Pirate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/drunk_pirate/im$_random.jpg"),
            ),
            TextButton(
                onPressed: _changeImage,
                child: const Text('Prochaine Question'))
          ],
        ),
      ),
    );
  }
}

class NIHE extends StatefulWidget {
  const NIHE({super.key});

  @override
  State<NIHE> createState() => _NIHEState();
}

class _NIHEState extends State<NIHE> {
  String currentSentence = '';
  List<dynamic> sentences = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    loadSentences();
  }

  Future<void> loadSentences() async {
    String jsonString = await rootBundle.loadString('assets/sentences.json');
    List<dynamic> data = json.decode(jsonString);
    int randomNumber = random.nextInt(data.length);
    setState(() {
      sentences = data;
      currentSentence = sentences[randomNumber]['sentence'];
    });
  }

  void _changeSentence() {
    int randomNumber = random.nextInt(sentences.length);

    setState(() {
      currentSentence = sentences[randomNumber]['sentence'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return newMethod();
  }

  Scaffold newMethod() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('NIHE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentSentence),
            TextButton(
                onPressed: _changeSentence,
                child: const Text('Prochaine Question'))
          ],
        ),
      ),
    );
  }
}

class Undercover extends StatefulWidget {
  const Undercover({super.key});

  @override
  State<Undercover> createState() => _UndercoverState();
}

class Player {
  String name;
  String assignedWord;
  bool isEliminated;
  bool isUndercover;

  Player(
      {required this.name,
      required this.assignedWord,
      this.isEliminated = false,
      this.isUndercover = false});
}

class _UndercoverState extends State<Undercover> {
  List<Player> players = [];
  Random random = Random();
  int undercovercount = 1;

  void addPlayer(String name) {
    if (name.isEmpty) {
      return;
    }
    setState(() {
      players.add(Player(
          name: name,
          assignedWord: '',
          isEliminated: false,
          isUndercover: false));
    });
  }

  void assignWords() {
    List<Tuple2<String, String>> words = [
      const Tuple2<String, String>('Ordinateur', "Téléphone"),
      const Tuple2<String, String>('Téléphone', "Ordinateur"),
      const Tuple2<String, String>('Sable', "Mer"),
      const Tuple2<String, String>('Mer', "Sable"),
      const Tuple2<String, String>('Mer', "Océan"),
      const Tuple2<String, String>('Professeur', "Etudiant"),
      const Tuple2<String, String>('Etudiant', "Professeur"),
      const Tuple2<String, String>('Pomme', "Poire"),
      const Tuple2<String, String>('Poire', "Pomme"),
      const Tuple2<String, String>('Pomme', "Banane"),
      const Tuple2<String, String>('Banane', "Pomme"),
      const Tuple2<String, String>('Tente', "Mobile-Home"),
      const Tuple2<String, String>('Mobile-Home', "Tente"),
      const Tuple2<String, String>('Moto', "Voiture"),
      const Tuple2<String, String>('Voiture', "Moto"),
      const Tuple2<String, String>('Voiture', "Camion"),
      const Tuple2<String, String>('Camion', "Voiture"),
      const Tuple2<String, String>('Carte Routière', "GPS"),
      const Tuple2<String, String>('GPS', "Carte Routière"),
      const Tuple2<String, String>('Restaurant', 'Cuisine'),
      const Tuple2<String, String>('Cuisine', 'Restaurant'),
      const Tuple2<String, String>('Bureau', 'Réunion'),
      const Tuple2<String, String>('Réunion', 'Bureau'),
      const Tuple2<String, String>('Hôpital', 'Médecin'),
      const Tuple2<String, String>('Médecin', 'Hôpital'),
      const Tuple2<String, String>('Séries', 'Film'),
      const Tuple2<String, String>('Film', 'Séries'),
      const Tuple2<String, String>('Cinéma', 'Théâtre'),
      const Tuple2<String, String>('Théâtre', 'Cinéma'),
      const Tuple2<String, String>('Parc d\'attractions', 'Manège'),
      const Tuple2<String, String>('Manège', 'Parc d\'attractions'),
      const Tuple2<String, String>('Bateau', 'Avion'),
      const Tuple2<String, String>('Avion', 'Bateau'),
      const Tuple2<String, String>('Voiture', 'Route'),
      const Tuple2<String, String>('Route', 'Voiture'),
      const Tuple2<String, String>('Montagne', 'Sommet'),
      const Tuple2<String, String>('Sommet', 'Montagne'),
      const Tuple2<String, String>('Musique', 'Danse'),
      const Tuple2<String, String>('Danse', 'Musique'),
      const Tuple2<String, String>('Livres', 'Bibliothèque'),
      const Tuple2<String, String>('Bibliothèque', 'Livres'),
      const Tuple2<String, String>('Football', 'Stade'),
      const Tuple2<String, String>('Stade', 'Football'),
      const Tuple2<String, String>('Voyage', 'Valise'),
      const Tuple2<String, String>('Valise', 'Voyage'),
      const Tuple2<String, String>('Chien', 'Os'),
      const Tuple2<String, String>('Os', 'Chien'),
      const Tuple2<String, String>('Café', 'Tasse'),
      const Tuple2<String, String>('Tasse', 'Café'),
      const Tuple2<String, String>('Jardin', 'Fleurs'),
      const Tuple2<String, String>('Fleurs', 'Jardin'),
      const Tuple2<String, String>('Lecture', 'Lunettes'),
      const Tuple2<String, String>('Lunettes', 'Lecture'),
      const Tuple2<String, String>('Peinture', 'Pinceau'),
      const Tuple2<String, String>('Pinceau', 'Peinture'),
      const Tuple2<String, String>('Train', 'Rails'),
      const Tuple2<String, String>('Rails', 'Train'),
      const Tuple2<String, String>('Guitare', 'Mélodie'),
      const Tuple2<String, String>('Mélodie', 'Guitare'),
      const Tuple2<String, String>('Photographie', 'Appareil'),
      const Tuple2<String, String>('Appareil', 'Photographie'),
      const Tuple2<String, String>('Chocolat', 'Sucré'),
      const Tuple2<String, String>('Sucré', 'Chocolat'),
      const Tuple2<String, String>('Château', 'Roi'),
      const Tuple2<String, String>('Roi', 'Château'),
      const Tuple2<String, String>('Glace', 'Cornet'),
      const Tuple2<String, String>('Cornet', 'Glace'),
      const Tuple2<String, String>('Arbre', 'Feuilles'),
      const Tuple2<String, String>('Feuilles', 'Arbre'),
      const Tuple2<String, String>('Étoile', 'Ciel'),
      const Tuple2<String, String>('Ciel', 'Étoile'),
      const Tuple2<String, String>('Théâtre', 'Acteur'),
      const Tuple2<String, String>('Acteur', 'Théâtre'),
      const Tuple2<String, String>('Basketball', 'Panier'),
      const Tuple2<String, String>('Panier', 'Basketball'),
      const Tuple2<String, String>('Horloge', 'Aiguilles'),
      const Tuple2<String, String>('Aiguilles', 'Horloge'),
      const Tuple2<String, String>('Restaurant', 'Serveur'),
      const Tuple2<String, String>('Serveur', 'Restaurant'),
      const Tuple2<String, String>('Étoile', 'Nuit'),
      const Tuple2<String, String>('Nuit', 'Étoile'),
      const Tuple2<String, String>('Rouge', 'Feu'),
      const Tuple2<String, String>('Feu', 'Rouge'),
      const Tuple2<String, String>('Miroir', 'Reflet'),
      const Tuple2<String, String>('Reflet', 'Miroir'),
      const Tuple2<String, String>('Cheval', 'Crinière'),
      const Tuple2<String, String>('Crinière', 'Cheval'),
      const Tuple2<String, String>('Ballon', 'Jonglerie'),
      const Tuple2<String, String>('Jonglerie', 'Ballon'),
      const Tuple2<String, String>('Bateau', 'Marin'),
      const Tuple2<String, String>('Marin', 'Bateau'),
      const Tuple2<String, String>('Science', 'Laboratoire'),
      const Tuple2<String, String>('Laboratoire', 'Science'),
      const Tuple2<String, String>('Fête', 'Ballons'),
      const Tuple2<String, String>('Ballons', 'Fête'),
      const Tuple2<String, String>('Hiver', 'Froid'),
      const Tuple2<String, String>('Froid', 'Hiver'),
      const Tuple2<String, String>('Parc', 'Banc'),
      const Tuple2<String, String>('Banc', 'Parc'),
      const Tuple2<String, String>('Chanson', 'Paroles'),
      const Tuple2<String, String>('Paroles', 'Chanson'),
      const Tuple2<String, String>('Vélo', 'Roue'),
      const Tuple2<String, String>('Roue', 'Vélo'),
    ]; // Liste des mots disponibles

    // Mélanger les mots
    words.shuffle();
    //Reset des joueurs
    for (int i = 0; i < players.length; i++) {
      players[i].assignedWord = '';
      players[i].isEliminated = false;
      players[i].isUndercover = false;
    }

    setState(() {
      // Donne le mot 2 à l'undercover*
      if (players.length < 3) {
        // Pas assez de joueurs
        //Affiche une fenetre d'erreur
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: const Text(
                  'Il faut au moins 3 joueurs pour jouer à Undercover'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Fermer la fenêtre de confirmation
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      if (undercovercount > players.length - 2 || undercovercount < 1) {
        // Trop d'undercover
        //Affiche une fenetre d'erreur
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: const Text(
                  'Il faut au moins 1 undercover et au plus le nombre de joueurs - 2'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Fermer la fenêtre de confirmation
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
      List<int> undercoverIndexes = [];
      int wordIndex = random.nextInt(words.length);
      for (int i = 0; i < undercovercount; i++) {
        int undercoverIndex = random.nextInt(players.length);
        while (players[undercoverIndex].isUndercover) {
          undercoverIndex = random.nextInt(players.length);
        }
        undercoverIndexes.add(undercoverIndex);
        players[undercoverIndex].assignedWord = words[wordIndex].item2;
        players[undercoverIndex].isUndercover = true;
      }

      // Donne les mots 1 aux autres joueurs
      for (int i = 0; i < players.length; i++) {
        if (undercoverIndexes.contains(i)) {
          continue;
        }
        players[i].assignedWord = words[wordIndex].item1;
      }
    });
  }

  void eliminatePlayer(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir éliminer ce joueur ?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fermer la fenêtre de confirmation
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  players[index].isEliminated = true;
                });
                Navigator.pop(context); // Fermer la fenêtre de confirmation
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Undercover'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: players.length <= 6 ? 2 : 3,
              children: List.generate(
                players.length,
                (index) {
                  Player player = players[index];
                  return LongPressDraggable(
                    data: player.assignedWord,
                    feedback: Card(
                      child: Container(
                        width: 200,
                        height: 80,
                        alignment: Alignment.center,
                        child: Text(player.assignedWord),
                      ),
                    ),
                    childWhenDragging: Container(),
                    child: Card(
                      color: player.isEliminated
                          ? player.isUndercover
                              ? Colors.red
                              : Colors.green
                          : Colors.white,
                      child: ListTile(
                        title: Text(player.name),
                        subtitle: player.isEliminated
                            ? player.isUndercover
                                ? const Text('Undercover')
                                : const Text('Eliminé')
                            : const Text('Appuyez et maintenez'),
                        onTap: () {
                          if (!player.isEliminated) {
                            eliminatePlayer(index);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          TextButton(
            onPressed: assignWords,
            child: const Text('Assigner les mots'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: const Text(
                    'Ajouter un joueur et régler le nombre d\'undercover'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: 'Nom du joueur',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: undercovercount.toString(),
                      onChanged: (value) {
                        setState(() {
                          undercovercount = int.tryParse(value) ?? 1;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nombre d\'undercover',
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      addPlayer(controller.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Ajouter'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
