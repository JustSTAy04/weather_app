import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Constants cons = Constants();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                color: cons.purple,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: cons.darkPurple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
            ),
            Image.asset('assets/welcome_totoro.png'),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: cons.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
              ),
              child: const Text(
                'Get started!',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
