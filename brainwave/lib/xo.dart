import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToe());
}

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Center(
          child: Board(),
        ),
      ),
    );
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late List<String> _board;
  late String _currentPlayer;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _board = List.filled(9, '');
    _currentPlayer = 'X';
  }

  void _handleTap(int index) {
    if (_board[index] == '') {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWinner()) {
          _showResultDialog('Player $_currentPlayer wins!');
        } else if (_board.every((square) => square != '')) {
          _showResultDialog('It\'s a draw!');
        } else {
          _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i * 3] != '' &&
          _board[i * 3] == _board[i * 3 + 1] &&
          _board[i * 3] == _board[i * 3 + 2]) {
        return true;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 3] &&
          _board[i] == _board[i + 6]) {
        return true;
      }
    }
    // Check diagonals
    if (_board[0] != '' &&
        _board[0] == _board[4] &&
        _board[0] == _board[8]) {
      return true;
    }
    if (_board[2] != '' &&
        _board[2] == _board[4] &&
        _board[2] == _board[6]) {
      return true;
    }
    return false;
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Game Over'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              _startGame();
            },
            child: Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: _board.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _handleTap(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                _board[index],
                style: TextStyle(fontSize: 40.0, color: Colors.blue),
              ),
            ),
          ),
        );
      },
    );
  }
}
