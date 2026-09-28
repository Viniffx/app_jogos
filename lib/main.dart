import 'package:flutter/material.dart';
import 'telas/login_tela.dart';
import 'tema/app_theme.dart';

void main() {
  runApp(const GameScoreApp());
}

class GameScoreApp extends StatelessWidget {
  const GameScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameScore',
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}