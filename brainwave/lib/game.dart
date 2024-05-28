import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const int rows = 20;
  static const int columns = 20;
  static const int initialSnakeLength = 3;
  static const Duration tickRate = Duration(milliseconds: 300);

  List<Point> snake = [Point(0, 0), Point(1, 0), Point(2, 0)];
  Point food = Point(5, 5);
  String direction = 'right';
  Timer? timer;

  void startGame() {
    timer?.cancel();
    timer = Timer.periodic(tickRate, (Timer timer) {
      setState(() {
        moveSnake();
        if (snake.contains(food)) {
          growSnake();
          generateFood();
        }
        if (isGameOver()) {
          timer.cancel();
        }
      });
    });
  }

  void moveSnake() {
    Point newHead;
    switch (direction) {
      case 'up':
        newHead = Point(snake.last.x, snake.last.y - 1);
        break;
      case 'down':
        newHead = Point(snake.last.x, snake.last.y + 1);
        break;
      case 'left':
        newHead = Point(snake.last.x - 1, snake.last.y);
        break;
      case 'right':
      default:
        newHead = Point(snake.last.x + 1, snake.last.y);
        break;
    }
    snake.add(newHead);
    snake.removeAt(0);
  }

  void growSnake() {
    Point newHead;
    switch (direction) {
      case 'up':
        newHead = Point(snake.last.x, snake.last.y - 1);
        break;
      case 'down':
        newHead = Point(snake.last.x, snake.last.y + 1);
        break;
      case 'left':
        newHead = Point(snake.last.x - 1, snake.last.y);
        break;
      case 'right':
      default:
        newHead = Point(snake.last.x + 1, snake.last.y);
        break;
    }
    snake.add(newHead);
  }

  void generateFood() {
    Random random = Random();
    food = Point(random.nextInt(columns), random.nextInt(rows));
  }

  bool isGameOver() {
    Point head = snake.last;
    if (head.x < 0 || head.x >= columns || head.y < 0 || head.y >= rows) {
      return true;
    }
    for (int i = 0; i < snake.length - 1; i++) {
      if (snake[i] == head) {
        return true;
      }
    }
    return false;
  }

  void changeDirection(String newDirection) {
    setState(() {
      direction = newDirection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white),
              ),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                ),
                itemCount: rows * columns,
                itemBuilder: (BuildContext context, int index) {
                  int x = index % columns;
                  int y = (index / columns).floor();
                  Point point = Point(x, y);
                  bool isSnake = snake.contains(point);
                  bool isFood = food == point;
                  return Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: isSnake ? Colors.green : isFood ? Colors.red : Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => changeDirection('up'),
                  child: Icon(Icons.arrow_upward),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => changeDirection('left'),
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => changeDirection('right'),
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => changeDirection('down'),
                  child: Icon(Icons.arrow_downward),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startGame,
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
