import 'package:flutter/material.dart';
import 'package:hangman/utils/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: Text(
          'Hangman',
          style: retroStyle(
            size: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 40,
            icon: const Icon(Icons.volume_up_sharp),
            color: Colors.purpleAccent,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
