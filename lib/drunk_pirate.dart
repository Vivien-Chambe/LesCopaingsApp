import 'dart:math';
import 'package:flutter/material.dart';

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
