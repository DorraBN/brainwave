import 'package:flutter/material.dart';
import 'package:brainwave/home1.dart'; // Import correct de home1.dart

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile with Sidebar',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Couleur mauve
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.purple,
  title: Text('Profile'),
),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple, // Couleur mauve pour l'en-tête du tiroir
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile_image.jpg'), // Ajout de l'image de profil
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.home), // Ajout de l'icône Home
                  SizedBox(width: 10),
                  Text('Home'),
                ],
              ),
               onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) =>Homepage ()));
                          },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.person), // Ajout de l'icône Person
                  SizedBox(width: 10),
                  Text('Profile'),
                ],
              ),
              onTap: () {
                // Add navigation logic here
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.settings), // Ajout de l'icône Settings
                  SizedBox(width: 10),
                  Text('Settings'),
                ],
              ),
              onTap: () {
                // Add navigation logic here
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout), // Ajout de l'icône Logout
                  SizedBox(width: 10),
                  Text('Logout'),
                ],
              ),
              onTap: () {
                // Add logout logic here
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is where the profile content goes...',
            ),
          ],
        ),
      ),
    );
  }
}
