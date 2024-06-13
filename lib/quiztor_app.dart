import 'package:flutter/material.dart';
import 'package:quiztor/home_page.dart';

class QuiztorApp extends StatelessWidget {
  const QuiztorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiztor',
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'Quiztor'),
    );
  }
}
