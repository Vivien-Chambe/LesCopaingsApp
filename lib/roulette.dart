import 'dart:math';
import 'package:flutter/material.dart';

class Bottle extends StatefulWidget {
  const Bottle({super.key});

  @override
  State<Bottle> createState() => _BottleState();
}

class _BottleState extends State<Bottle> with SingleTickerProviderStateMixin {
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu de Roue'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Conteneur représentant la roue
            Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: AnimatedRotation(
                turns: turns,
                duration: Duration(seconds: Random().nextInt(3) + 2),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(Icons.north, size: 200),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  turns += Random().nextDouble() * 5 + 3;
                });
              },
              child: const Text('Tourner'),
            ),
          ],
        ),
      ),
    );
  }
}
