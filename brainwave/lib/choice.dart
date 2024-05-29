import 'dart:convert';
import 'package:brainwave/quran.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage with Icons and Text',
      home: Choicepage(),
    );
  }
}

class Choicepage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'icon': Icons.mosque, 'text': 'اقرأ السورة'},
    {'icon': Icons.music_note_outlined, 'text': 'استمع للسورة'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (items[index]['text'] == 'استمع للسورة') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecitersPage()),
                  );
                } else if (items[index]['text'] == 'اقرأ السورة') {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuranPage1()),
                  );
                  // Gérer la navigation vers la page du Coran
                }
              },
              child: Card(
                color: Colors.purple,
                elevation: 4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        items[index]['icon'],
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        items[index]['text'],
                        style: TextStyle(color: Colors.white),
                        textDirection: TextDirection.rtl,
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

class RecitersPage extends StatefulWidget {
  @override
  _RecitersPageState createState() => _RecitersPageState();
}

class _RecitersPageState extends State<RecitersPage> {
  List<String> reciters = [];

  @override
  void initState() {
    super.initState();
    fetchReciters();
  }

  Future<void> fetchReciters() async {
    final response = await http.get(Uri.parse('https://quranapi.pages.dev/api/reciters.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        reciters = data.values.cast<String>().toList();
      });
    } else {
      throw Exception('Failed to load reciters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Reciters'),
      ),
      body: ListView.builder(
        itemCount: reciters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reciters[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuranPage(selectedReciter: reciters[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class QuranPage extends StatefulWidget {
  final String selectedReciter;

  QuranPage({required this.selectedReciter});

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<dynamic> _surahs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    try {
      final response = await http.get(Uri.parse('https://quranapi.pages.dev/api/surah.json'));

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _surahs = data;
          _loading = false;
        });
      } else {
        throw Exception('Failed to load Surahs');
      }
    } catch (error) {
      print('Error fetching Surahs: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Page'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _surahs.length,
              itemBuilder: (context, index) {
                var surah = _surahs[index];
                var surahNo = index + 1; // Assume que le numéro de sourate commence à partir de 1 et s'incrémente
                return Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        '../../assets/quran.jpeg',
                        width: 40,
                        height: 40,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(surah['surahName']),
                          Text(
                            surah['surahNameArabic'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Amiri', // Assurez-vous d'avoir une police arabe appropriée
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(surah['surahNameTranslation']),
                      trailing: Text('Total Ayah: ${surah['totalAyah']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioPage(reciter: widget.selectedReciter, surahNo: surahNo),
                          ),
                        );
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
    );
  }
}

class AudioPage extends StatelessWidget {
  final String reciter;
  final int surahNo;

  AudioPage({required this.reciter, required this.surahNo});

  @override
  Widget build(BuildContext context) {
    final audioUrl = 'https://quranaudio.pages.dev/$reciter/$surahNo.mp3';
    // Vous pouvez jouer l'audio en utilisant audioUrl
    return Scaffold(
      appBar: AppBar(
        title: Text('Playing Audio'),
      ),
      body: Center(
        child: Text('Audio will be played here from: $audioUrl'),
      ),
    );
  }
}
