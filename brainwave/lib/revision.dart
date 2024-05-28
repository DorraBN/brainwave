import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revision App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RevisionPage(),
    );
  }
}

class RevisionPage extends StatefulWidget {
  @override
  _RevisionPageState createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  List<String> subjects = ["Math", "Science", "History", "Geography"];
  List<bool> isRevised = [false, false, false, false];

  void _toggleRevised(int index) {
    setState(() {
      isRevised[index] = !isRevised[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Révision'),
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subjects[index]),
            trailing: IconButton(
              icon: Icon(
                isRevised[index] ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              onPressed: () => _toggleRevised(index),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubjectDetailPage(subject: subjects[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new subject
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SubjectDetailPage extends StatefulWidget {
  final String subject;

  SubjectDetailPage({required this.subject});

  @override
  _SubjectDetailPageState createState() => _SubjectDetailPageState();
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isRunning = false;
  Duration duration = Duration();
  Duration initialDuration = Duration(minutes: 25); // Default revision time

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void startTimer() {
    setState(() {
      isRunning = true;
      duration = initialDuration;
    });

    Future.delayed(duration, () {
      _showNotification();
      setState(() {
        isRunning = false;
      });
    });

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (duration.inSeconds <= 0) {
          timer.cancel();
        } else {
          duration = Duration(seconds: duration.inSeconds - 1);
        }
      });
    });
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_channel',
      'Alarm',
      channelDescription: 'Channel for Alarm notification',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      enableVibration: true,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Time\'s up!',
      'Your revision time is over.',
      platformChannelSpecifics,
      payload: 'Alarm Notification',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Revision Timer',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRunning ? null : startTimer,
              child: Text(isRunning ? 'Revising...' : 'Start Revision'),
            ),
          ],
        ),
      ),
    );
  }
}
