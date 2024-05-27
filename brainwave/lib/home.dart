import 'package:brainwave/login.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(
        pages: [
          OnboardingPageModel(
            backgroundImage: const AssetImage('../../assets/b2.png'),
            title: "Welcome to BrainWave!",
            description: "The ultimate platform for students to explore their interests and enhance their learning experience.",
            textColor: Color.fromARGB(255, 247, 245, 245),
          ),
          OnboardingPageModel(
            backgroundImage: const AssetImage('../../assets/b6.jpg'),
            title: 'Discover New Horizons.',
            description: 'Explore a vast array of subjects, topics, and resources tailored to your academic and personal interests.',
            textColor: const Color.fromARGB(255, 0, 0, 0),
          ),
          OnboardingPageModel(
            backgroundImage: const AssetImage('../../assets/b4.jpg'),
            title: 'Connect with Peers',
            description: 'Engage in discussions, share knowledge, and collaborate with fellow students who share your passions.',
            textColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;

  const OnboardingPagePresenter({
    Key? key,
    required this.pages,
  }) : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: item.backgroundImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: item.textColor,
                                    fontSize: 24, // Taille de la police du titre
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8.0),
                            child: Text(
                              item.description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: item.textColor,
                                    fontSize: 16, // Taille de la police de la description
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages.map((item) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _currentPage == widget.pages.indexOf(item) ? 30 : 8,
                  height: 8,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )).toList(),
              ),
              GestureDetector(
                onTap: () {
                  if (_currentPage == widget.pages.length - 1) {
                    // Naviguer vers la page de connexion (LoginPage)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {
                    _pageController.animateToPage(
                      _currentPage + 1,
                      curve: Curves.easeInOutCubic,
                      duration: const Duration(milliseconds: 250),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    _currentPage == widget.pages.length - 1 ? Icons.done : Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;

  final AssetImage backgroundImage;
  final Color textColor;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.backgroundImage,
    this.textColor = const Color.fromARGB(255, 0, 0, 0),
  });
}

