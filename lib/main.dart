import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'intro_screen.dart';

void main() => runApp(const PolylinguaApp());

class PolylinguaApp extends StatelessWidget {
  const PolylinguaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POLylINGUA+',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF5B5BD6),
        useMaterial3: true,
      ),
      // The intro is the startup screen; it replaces itself with the home screen.
      home: IntroScreen(
        onFinished: (context) => Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
        ),
      ),
    );
  }
}
