import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangman/utils/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String word = wordsList[Random().nextInt(wordsList.length)];
  List guessedAlphabets = [];
  int points = 0;
  int status = 0;
  List<String> images = [
    'assets/images/hangman0.png',
    'assets/images/hangman1.png',
    'assets/images/hangman2.png',
    'assets/images/hangman3.png',
    'assets/images/hangman4.png',
    'assets/images/hangman5.png',
    'assets/images/hangman6.png',
  ];

  String handleText() {
    String displayWord = '';
    for (var i = 0; i < word.length; i++) {
      String char = word[i];
      if (guessedAlphabets.contains(char)) {
        displayWord += '$char ';
      } else {
        displayWord += '? ';
      }
    }
    return displayWord;
  }

  checkLetter(String letter) {
    if (word.contains(letter)) {
      setState(() {
        guessedAlphabets.add(letter);
        points += 5;
      });
    } else if (status != 6) {
      setState(() {
        status += 1;
        points -= 5;
      });
    } else {
      // TODO: You Lost
    }

    bool isWon = true;
    for (var i = 0; i < word.length; i++) {
      String char = word[i];
      if (!guessedAlphabets.contains(char)) {
        setState(() {
          isWon = false;
        });
        break;
      }
    }

    if (isWon) {
      // TODO: You Won
    }
  }

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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3.5,
                height: 30,
                decoration: const BoxDecoration(color: Colors.lightBlueAccent),
                child: Text(
                  '$points points',
                  style: retroStyle(
                    size: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Image(
                width: 155,
                height: 155,
                image: AssetImage(images[status]),
                color: Colors.white,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 15),
              Text(
                '7 lives left',
                style: retroStyle(
                  size: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                handleText(),
                style: retroStyle(
                  size: 53,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: letters.map((letter) {
                  return InkWell(
                    onTap: () => checkLetter(letter),
                    child: Center(
                      child: Text(
                        letter,
                        style: retroStyle(
                          size: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
