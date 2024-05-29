import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Amiri', // Set the default font to Amiri
      ),
      home: QuranPage1(),
    );
  }
}

class QuranPage1 extends StatefulWidget {
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage1> {
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
      // Gérer l'erreur ici
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
                var surahNo = index + 1; // Assuming surah number starts from 1 and increments
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
                              fontFamily: 'Amiri', // Ensure you have a suitable Arabic font
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
                            builder: (context) => SurahDetailPage(surahNumber: surahNo),
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

class SurahDetailPage extends StatefulWidget {
  final int surahNumber;

  SurahDetailPage({required this.surahNumber});

  @override
  _SurahDetailPageState createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  Map<String, dynamic>? surah;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchSurah(widget.surahNumber);
  }

  Future<void> fetchSurah(int surahNumber) async {
    try {
      final response = await http.get(Uri.parse('https://quranapi.pages.dev/api/$surahNumber.json'));

      if (response.statusCode == 200) {
        setState(() {
          surah = json.decode(utf8.decode(response.bodyBytes));
          _loading = false;
        });
      } else {
        throw Exception('Failed to load Surah $surahNumber');
      }
    } catch (error) {
      print('Error fetching Surah: $error');
      // Gérer l'erreur ici
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _loading ? Text('Loading...') : Text(surah?['surahName'] ?? 'Surah Detail'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Surah ${surah?['surahName']} (${surah?['surahNameTranslation']})',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Revelation Place: ${surah?['revelationPlace']}',
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    Text(
                      'Total Ayah: ${surah?['totalAyah']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text('English:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    for (var ayah in surah?['english'] ?? []) Text(ayah),
                    SizedBox(height: 10),
                    Text('Arabic:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    for (var ayah in surah?['arabic1'] ?? [])
                      Text(
                        ayah,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Amiri', // Ensure you have a suitable Arabic font
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
