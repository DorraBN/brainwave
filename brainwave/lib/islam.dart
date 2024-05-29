import 'package:brainwave/choice.dart';
import 'package:brainwave/clock.dart';
import 'package:brainwave/hadith.dart';
import 'package:brainwave/pray.dart';
import 'package:brainwave/quran.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage with Icons and Text',
      home: Islampage(),
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
      appBar: AppBar(
        title: Text('صفحة الإسلام'),
      ),
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
                if (items[index]['text'] == 'القرآن الكريم') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Choicepage()),
                  );
                }
                else  if (items[index]['text'] == 'الصلاة') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrayPage()),
                  );
                }
                else  if (items[index]['text'] == 'أوقات الصلاة') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrayerTimesPage()),
                  );
                }
                else  if (items[index]['text'] == 'الأدعية') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HadithPage()),
                  );
                }},
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
