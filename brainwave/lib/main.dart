
import 'package:brainwave/home.dart';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb; // Importez kIsWeb pour détecter si l'application est web


void main() async {
 
  // Lancez l'application Flutter
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
    //  home: ProfilePage(), 
        home:WelcomePage()//ConcentricAnimationOnboarding()// Remplacez ceci par une instance de Register
      // home: ConcentricAnimationOnboarding() ,
     //home: MainScreen(),
    );
  }
}
