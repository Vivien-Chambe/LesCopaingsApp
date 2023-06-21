// Je veux faire une version mobile du PMU

import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

class PMU extends StatefulWidget {
  const PMU({Key? key}) : super(key: key);
  @override
  _PMUState createState() => _PMUState();
}

class _PMUState extends State<PMU> with TickerProviderStateMixin {
  double club_position = 0.0;
  double heart_position = 0.0;
  double spade_position = 0.0;
  double diamond_position = 0.0;

  int number_drawed = 0;

  int draw() {
    Random random = new Random();
    int randomNumber = random.nextInt(4);
    return randomNumber;
  }

  void make_go_back() {
    int drawed = draw();
    setState(() {
      if (drawed == 0) {
        club_position = club_position + 50;
      } else if (drawed == 1) {
        heart_position = heart_position + 50;
      } else if (drawed == 2) {
        spade_position = spade_position + 50;
      } else if (drawed == 3) {
        diamond_position = diamond_position + 50;
      }
    });
  }

  void make_move() {
    int drawed = draw();
    number_drawed = number_drawed + 1;

    if (drawed == 0) {
      setState(() {
        club_position = club_position - 50;
      });
    } else if (drawed == 1) {
      setState(() {
        heart_position = heart_position - 50;
      });
    } else if (drawed == 2) {
      setState(() {
        spade_position = spade_position - 50;
      });
    } else if (drawed == 3) {
      setState(() {
        diamond_position = diamond_position - 50;
      });
      if (number_drawed == 5) {
        make_go_back();
        number_drawed = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les 4 Rois'),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(children: [
            Container(
              width: 50,
              height: 50,
              child: Transform.translate(
                offset: Offset(0, club_position),
                child: Icon(Icons.north, size: 50),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Transform.translate(
                offset: Offset(0, heart_position),
                child: Icon(Icons.north, size: 50),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Transform.translate(
                offset: Offset(0, spade_position),
                child: Icon(Icons.north, size: 50),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Transform.translate(
                offset: Offset(0, diamond_position),
                child: Icon(Icons.north, size: 50),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: make_move, child: const Text('Tirer')),
        ]),
      ]),
    );
  }
}

class FlipableCard extends StatefulWidget {
  const FlipableCard({Key? key, required this.suit}) : super(key: key);
  final String suit;

  @override
  State<FlipableCard> createState() => _FlipableCardState();
}

class _FlipableCardState extends State<FlipableCard> {
  bool _isFront = true;

  void _flip() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _isFront
            ? Container(
                width: 20,
                height: 50,
                key: const ValueKey<bool>(true),
                child: Card(
                  color: Colors.blue,
                  child: Column(
                    children: const [],
                  ),
                ),
              )
            : Container(
                width: 20,
                height: 50,
                key: const ValueKey<bool>(false),
                child: Card(
                  color: Colors.red,
                  child: Column(
                    children: const [],
                  ),
                ),
              ),
      ),
    );
  }
}
