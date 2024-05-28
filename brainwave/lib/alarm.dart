import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Alarm App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlarmPage(),
    );
  }
}

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Alarm App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selected Time: ${selectedTime.format(context)}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Vous pouvez ajouter la logique de réglage de l'alarme ici.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Alarm set for ${selectedTime.format(context)}')),
                );
              },
              child: Text('Set Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
