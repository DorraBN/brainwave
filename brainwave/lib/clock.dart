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
      title: 'Prayer Times App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrayerTimesPage(),
    );
  }
}

class PrayerTimesPage extends StatefulWidget {
  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  Map<String, dynamic>? _prayerTimes;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final response = await http.get(Uri.parse('http://api.aladhan.com/v1/timings/2024-05-29'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _prayerTimes = data['data']['timings'];
        });
      } else {
        throw Exception('Failed to load prayer times: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching prayer times: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times'),
      ),
      body: _errorMessage.isNotEmpty
          ? Center(
              child: Text(_errorMessage),
            )
          : _prayerTimes != null
              ? ListView.builder(
                  itemCount: _prayerTimes!.length,
                  itemBuilder: (context, index) {
                    final prayerName = _prayerTimes!.keys.elementAt(index);
                    final prayerTime = _prayerTimes![prayerName];
                    return ListTile(
                      title: Text(prayerName),
                      subtitle: Text(prayerTime),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator()),
    );
  }
}
