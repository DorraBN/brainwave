import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinosaur Game',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const double gravity = 0.8;
  static const double jumpSpeed = -12;
  static const double groundHeight = 100;

  double dinoY = 0;
  double dinoYSpeed = 0;
  bool isJumping = false;
  bool gameStarted = false;
  Timer? timer;

  void startGame() {
    dinoY = 0;
    dinoYSpeed = 0;
    gameStarted = true;
    timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      update();
    });
  }

  void update() {
    if (isJumping) {
      dinoYSpeed += gravity;
      dinoY += dinoYSpeed;
      if (dinoY >= 0) {
        dinoY = 0;
        dinoYSpeed = 0;
        isJumping = false;
      }
    }
    setState(() {});
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      dinoYSpeed = jumpSpeed;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (!gameStarted) {
            startGame();
          } else {
            jump();
          }
        },
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Tap to Start',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 30),
              alignment: Alignment(0, 1 - (groundHeight / MediaQuery.of(context).size.height)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: groundHeight,
                color: Colors.green,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 30),
              alignment: Alignment(0, 1 - (groundHeight / MediaQuery.of(context).size.height) - (dinoY / MediaQuery.of(context).size.height)),
              child: Image.asset(
                'assets/dino.png',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
