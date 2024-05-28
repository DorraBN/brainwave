import 'package:brainwave/alarm.dart';
import 'package:brainwave/game.dart';
import 'package:brainwave/note.dart';
import 'package:brainwave/profile.dart';
import 'package:brainwave/revision.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage with Icons and Text',
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'icon': Icons.home, 'text': 'Home'},
    {'icon': Icons.person, 'text': 'Profile'},
    {'icon': Icons.music_note, 'text': 'Music'},
    {'icon': Icons.assignment, 'text': 'Revision'},
    {'icon': Icons.folder, 'text': 'Folder'},
    {'icon': Icons.message, 'text': 'Messages'},
    {'icon': Icons.notification_important, 'text': 'Notification'},
    {'icon': Icons.alarm_on, 'text': 'Alarm On'},
    {'icon': Icons.menu_book_outlined, 'text': 'book'},
    {'icon': Icons.video_chat, 'text': 'lessons'},
    {'icon': Icons.language_rounded, 'text': 'language'},
    {'icon': Icons.work_history_outlined, 'text': 'internship'},
     {'icon': Icons.map, 'text': 'maproad'},
     {'icon': Icons.cookie, 'text': 'cook'},
       {'icon': Icons.mosque, 'text': 'pray'},
         {'icon': Icons.games, 'text': 'game'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Change this to the number of columns you want
            childAspectRatio: 3 / 2, // Adjust the aspect ratio as needed
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (items[index]['text'] == 'Profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                }
                  else if (items[index]['text'] == 'Notification') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotePage ()),
                  );
                }
                 else if (items[index]['text'] == 'Alarm On') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlarmPage ()),
                  );
                }
                else if (items[index]['text'] == 'Revision') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RevisionPage ()),
                  );
                }
                else if (items[index]['text'] == 'game') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage ()),
                  );
                }
              },
              child: Card(
                color: Colors.purple, // Set card color to mauve
                elevation: 4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        items[index]['icon'],
                        size: 50,
                        color: Colors.white, // Change icon color to white for better contrast
                      ),
                      SizedBox(height: 10),
                      Text(
                        items[index]['text'],
                        style: TextStyle(color: Colors.white), // Change text color to white
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

