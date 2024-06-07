import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hangman/utils/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  String word = wordsList[Random().nextInt(wordsList.length)];
  List guessedAlphabets = [];
  int points = 0;
  int status = 0;
  bool soundOn = true;
  List<String> images = [
    'assets/images/hangman0.png',
    'assets/images/hangman1.png',
    'assets/images/hangman2.png',
    'assets/images/hangman3.png',
    'assets/images/hangman4.png',
    'assets/images/hangman5.png',
    'assets/images/hangman6.png',
  ];

  Future<void> playSound(String sound) async {
    if (soundOn) {
      await audioPlayer.play(AssetSource('sounds/$sound'));
    }
  }

  openDialog(String title) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 180,
            decoration: const BoxDecoration(color: Colors.purpleAccent),
            child: Column(
              children: [
                Text(
                  title,
                  style: retroStyle(
                    size: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  'You points: $points',
                  style: retroStyle(
                    size: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        status = 0;
                        guessedAlphabets.clear();
                        points = 0;
                        word = wordsList[Random().nextInt(wordsList.length)];
                      });
                      playSound('restart.mp3');
                    },
                    child: Center(
                      child: Text(
                        'Play Again',
                        style: retroStyle(
                          size: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

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
      playSound('correct.mp3');
    } else if (status != 6) {
      setState(() {
        status += 1;
        points -= 5;
      });
      playSound('wrong.mp3');
    } else {
      openDialog('You Lost');
      playSound('lost.mp3');
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
      openDialog('Hurray, you Won!');
      playSound('won.mp3');
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
            icon:
                Icon(soundOn ? Icons.volume_up_sharp : Icons.volume_off_sharp),
            color: Colors.purpleAccent,
            onPressed: () {
              setState(() {
                soundOn = !soundOn;
              });
            },
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
                '${7 - status} lives left',
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
