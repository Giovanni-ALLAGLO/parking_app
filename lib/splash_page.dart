import 'package:flutter/material.dart';
import 'myHomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 1, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green,
              Colors.lightGreen,
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              padding: EdgeInsets.all(16.0), // Ajoute un espace autour du texte
              child: Text(
                'Parking Star',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold, color : Colors.white,
                ),
              ),),
              FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  'assets/rootMap.gif', // Chemin vers le fichier GIF
                  width: 520,
                  height: 420,
                ),
              ),
              SizedBox(height: 4),
              ScaleTransition(
                scale: _buttonAnimation,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    textStyle: TextStyle(fontSize: 25,color : Colors.black),                  ),
                  child: Text('Commencer',style: TextStyle(
                    fontWeight: FontWeight.bold, color : Colors.white),
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
