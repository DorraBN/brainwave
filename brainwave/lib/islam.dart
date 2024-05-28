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
      home:Islampage(),
    );
  }
}

class Islampage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'icon': Icons.star_half, 'text': 'الأدعية'},
    {'icon': Icons.access_time, 'text': 'أوقات الصلاة'},
    {'icon': Icons.mosque, 'text': 'الصلاة'},
    {'icon': Icons.book, 'text': 'القرآن الكريم'},
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

