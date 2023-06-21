// ignore_for_file: file_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

//TODO Creer des catégories de questions

class NIHE extends StatefulWidget {
  const NIHE({super.key});

  @override
  State<NIHE> createState() => _NIHEState();
}

class _NIHEState extends State<NIHE> {
  String currentSentence = '';
  List<dynamic> sentences = [];
  List<dynamic> sentencesSafe = [];
  Random random = Random();
  bool safeforwork = false;

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
            //I want the card to be center of the screen
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  currentSentence,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            TextButton(
                onPressed: _changeSentence,
                child: const Text('Prochaine Question'))
          ],
        ),
      ),
    );
  }
}
