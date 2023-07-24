import 'package:flutter/material.dart';
import 'package:test_app/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

ThemeData theme = ThemeData(useMaterial3: true);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: theme,
    );
  }
}
