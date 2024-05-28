import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotePage(),
    );
  }
}

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Widget> blocs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              '../../assets/b4.jpg', // chemin de votre image
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: blocs,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            blocs.add(EditableBlock());
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class EditableBlock extends StatefulWidget {
  @override
  _EditableBlockState createState() => _EditableBlockState();
}

class _EditableBlockState extends State<EditableBlock> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Entrez votre texte ici...',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // Ouvrir la boîte de dialogue pour sélectionner un emoji
                },
                icon: Icon(Icons.restore_from_trash_sharp),
              ),
              IconButton(
                onPressed: () {
                  // Ouvrir la boîte de dialogue pour sélectionner une icône
                },
                icon: Icon(Icons.save),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          // Afficher ici les emojis ou les icônes sélectionnés
        ],
      ),
    );
  }
}
