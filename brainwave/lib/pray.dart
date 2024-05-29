import 'package:flutter/material.dart';

void main() {
  runApp(PrayPageApp());
}

class PrayPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrayPage(),
    );
  }
}

class PrayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PrayPage'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideWidget(
              title: 'Les Cinq Prières Obligatoires (Salat)',
              content: [
                'Fajr : La prière de l\'aube, avant le lever du soleil.',
                'Dhuhr : La prière du midi, après le passage du zénith du soleil.',
                'Asr : La prière de l\'après-midi, avant le coucher du soleil.',
                'Maghrib : La prière du coucher du soleil, juste après celui-ci.',
                'Isha : La prière de la nuit, après le coucher du soleil et avant minuit.',
              ],
            ),
            SlideWidget(
              title: 'Les Nombreux Bienfaits de la Prière',
              content: [
                'Renforce la connexion spirituelle avec Allah.',
                'Apaise l\'esprit et procure la tranquillité intérieure.',
                'Renforce la discipline personnelle et la régularité.',
                'Favorise la concentration et la méditation.',
                'Inculque le sens de la communauté et de l\'unité.',
              ],
            ),
          
            SlideWidget(
              title: 'L\'Importance de l\'Heure de la Prière',
              content: [
                'Fajr : Avant le lever du soleil, symbolise le début d\'une nouvelle journée sous la protection divine.',
                'Dhuhr : Au milieu de la journée, marque une pause pour se recentrer sur sa foi au milieu des activités.',
                'Asr : L\'après-midi, une pause pour remercier Allah pour les bénédictions reçues dans la journée.',
                'Maghrib : Au coucher du soleil, gratitude pour les bienfaits de la journée et demande de pardon.',
                'Isha : La nuit, moment de réflexion sur les actions de la journée et demande de protection pour la nuit à venir.',
              ],
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Naviguer vers la sélection de la prière
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectPrayerPage(),
                    ),
                  );
                },
                child: Text('Sélectionner une prière'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideWidget extends StatelessWidget {
  final String title;
  final List<String> content;

  SlideWidget({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content
                  .map((item) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text('• $item'),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}


class SelectPrayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sélectionner une prière'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrayerStepPage(prayer: 'Fajr'),
                  ),
                );
              },
              text: 'Fajr',
              icon: Icons.wb_sunny, // Icône pour Fajr
            ),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrayerStepPage(prayer: 'Dhuhr'),
                  ),
                );
              },
              text: 'Dhuhr',
              imageUrl: 'https://example.com/dhuhr_image.jpg', // Image pour Dhuhr
            ),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrayerStepPage(prayer: 'Asr'),
                  ),
                );
              },
              text: 'Asr',
              icon: Icons.access_time, // Icône pour Asr
            ),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrayerStepPage(prayer: 'Maghrib'),
                  ),
                );
              },
              text: 'Maghrib',
              imageUrl: 'https://example.com/maghrib_image.jpg', // Image pour Maghrib
            ),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrayerStepPage(prayer: 'Isha'),
                  ),
                );
              },
              text: 'Isha',
              icon: Icons.nightlight_round, // Icône pour Isha
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final String? imageUrl;

  CustomButton({required this.onPressed, required this.text, this.icon, this.imageUrl});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: _isHovering ? Colors.blue.shade200 : Colors.blue,
      ),
      child: InkWell(
        onTap: widget.onPressed,
        onHover: (isHovering) {
          setState(() {
            _isHovering = isHovering;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) // Afficher l'icône si elle est définie
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 24.0,
                ),
              SizedBox(width: 10.0),
              Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              if (widget.imageUrl != null) // Afficher l'image si elle est définie
                SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Image.network(widget.imageUrl!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class PrayerStepPage extends StatelessWidget {
  final String prayer;

  PrayerStepPage({required this.prayer});

  @override
  Widget build(BuildContext context) {
    // Placeholder pour l'affichage de la première étape de la prière sélectionnée
    return Scaffold(
      appBar: AppBar(
        title: Text('Étapes de $prayer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Étape 1 de $prayer',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            // Ajouter l'image et la description de la première étape ici
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la prochaine étape de la prière
                // Ici, vous pouvez implémenter la logique pour passer à la prochaine étape de la prière
                // Par exemple, si vous avez une liste d'étapes pour chaque prière, vous pouvez naviguer vers l'étape suivante dans cette liste.
              },
              child: Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }
}
