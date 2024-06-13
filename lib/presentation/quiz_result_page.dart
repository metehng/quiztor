import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage._();

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const QuizResultPage._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('CALCULATE RESULT'),
      ),
    );
  }
}
