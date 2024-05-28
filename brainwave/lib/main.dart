
import 'package:brainwave/home.dart';

import 'package:brainwave/profile.dart';
import 'package:brainwave/xo.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb; // Importez kIsWeb pour détecter si l'application est web


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

        home:TicTacToe()
      
    );
  }
}
