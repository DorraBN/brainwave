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
      title: 'Hadith App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat', // Utilisation d'une police de caractères personnalisée
      ),
      home: HadithPage(),
    );
  }
}

class HadithPage extends StatefulWidget {
  @override
  _HadithPageState createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  List<String>? _editions;
  String? _selectedEdition;
  String? _hadithText;
  String? _posterUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchEditions();
  }

  Future<void> fetchEditions() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await http.get(Uri.parse(
          'https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions.json'));

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        print('Editions API Response: $data'); // Debug print to inspect the response
        if (data is Map) {
          final List<String> editions =
              data.values.map<String>((value) => value.toString()).toList();
          setState(() {
            _editions = editions;
          });
        } else {
          throw Exception('Invalid data format for editions');
        }
      } else {
        throw Exception('Failed to load editions: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching editions: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchHadith() async {
    if (_selectedEdition != null) {
      try {
        setState(() {
          _isLoading = true;
        });
        final response = await http.get(Uri.parse(
            'https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/$_selectedEdition.json'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          // Extraire les données de la carte
          final hadith = data['hadith'];
          final posterUrl = data['poster'];
          setState(() {
            _hadithText = hadith;
            _posterUrl = posterUrl;
          });
        } else {
          throw Exception('Failed to load hadith: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching hadith: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hadith App'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildHadithContent(),
    );
  }

  Widget _buildHadithContent() {
    if (_editions == null) {
      return Center(
        child: Text('Failed to load editions'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: DropdownButton<String>(
            hint: Text(
              'Select Edition',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            value: _selectedEdition,
            items: _editions!.map<DropdownMenuItem<String>>((edition) {
              return DropdownMenuItem<String>(
                value: edition,
                child: Text(
                  edition,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedEdition = value;
              });
            },
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            fetchHadith();
          },
          child: Text('Fetch Hadith'),
        ),
        SizedBox(height: 20),
        if (_hadithText != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 5, // Ajout d'une ombre à la carte
                child: Column(
                  children: [
                    if (_posterUrl != null)
                      Image.network(
                        _posterUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        _hadithText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
